#!/usr/bin/env python3
"""将 idbloader 和 U-Boot FIT 写入 eMMC 镜像。"""

import os
import sys

out, loader, fit = sys.argv[1:]
loader_offset, fit_offset = 64 * 512, 16384 * 512
loader_size, fit_size = os.path.getsize(loader), os.path.getsize(fit)
if not loader_size or not fit_size or loader_offset + loader_size > fit_offset:
    raise SystemExit('Empty image component or idbloader overlaps FIT')
image_size = max(16 * 1024 * 1024, (fit_offset + fit_size + 511) // 512 * 512)
with open(out, 'wb') as image:
    image.truncate(image_size)
    for offset, path in ((loader_offset, loader), (fit_offset, fit)):
        image.seek(offset)
        with open(path, 'rb') as component:
            while True:
                chunk = component.read(1024 * 1024)
                if not chunk:
                    break
                image.write(chunk)
