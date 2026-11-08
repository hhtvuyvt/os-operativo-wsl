#!/usr/bin/env bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit

exec env SDL_VIDEO_X11_XSHM=0 bochs -f bochs_config
