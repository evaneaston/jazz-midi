#!/bin/bash
set -e -o pipefail

if [[ "$(uname -s)" != "Linux" ]]; then
    echo "Error: This script must be run on Linux (detected: $(uname -s))"
    exit 1
fi
if [[ "$(uname -m)" != "aarch64" ]]; then
    echo "Error: This script must be run on ARM64 architecture (detected: $(uname -m))"
    exit 1
fi

echo "Building jazz-midi for ARM64 Linux..."
if ! command -v node-gyp &> /dev/null; then
    echo "Error: node-gyp not found"
    exit 1
fi
if ! pkg-config --exists alsa 2>/dev/null; then
    echo "Error: ALSA dev libraries not found"
    exit 1
fi

cd node-gyp
node-gyp rebuild
mkdir -p ../node/bin/linuxa64
cp build/Release/jazz.node ../node/bin/linuxa64/
echo "Built successfully!"
