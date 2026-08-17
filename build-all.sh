#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Detect package manager (prefer pnpm if available, fallback to npm)
if command -v pnpm &> /dev/null; then
    PKG_MGR="pnpm"
else
    PKG_MGR="npm"
fi

echo "========================================"
echo " Starting build and test for all projects"
echo " Using package manager: $PKG_MGR"
echo "========================================"

for dir in */; do
    dir="${dir%/}"
    if [ -f "$dir/package.json" ]; then
        echo ""
        echo "========================================"
        echo " Processing: $dir"
        echo "========================================"
        
        (
            cd "$dir"
            
            # Check for test script in package.json
            if grep -q '"test":' package.json; then
                echo "--> Running test command..."
                $PKG_MGR run test
            else
                echo "--> No test script defined in package.json. Skipping test."
            fi

            # Check for build script in package.json
            if grep -q '"build":' package.json; then
                echo "--> Running build command..."
                $PKG_MGR run build
            else
                echo "--> No build script defined in package.json. Skipping build."
            fi
        )
    fi
done

echo ""
echo "========================================"
echo " Build and test process complete for all projects!"
echo "========================================"
