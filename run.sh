#!/usr/bin/env bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
qemu-system-i386 -drive "file=${SCRIPT_DIR}/build/main_floppy.img,format=raw,if=floppy"
