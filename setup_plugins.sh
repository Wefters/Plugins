#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Move .git out of Plugins/Plugins if trapped in nested folder
if [ -d "Plugins/.git" ] && [ ! -d ".git" ]; then
    echo "==> Moving .git from Plugins/Plugins to current directory..."
    mv Plugins/.git .
    rmdir Plugins 2>/dev/null || true
fi

echo "==> Syncing git submodules configuration..."
git submodule sync

echo "==> Initializing and cloning all plugin submodules..."
git submodule update --init --recursive

remote_url = "git@github.com:Wefters/"

declare -A PLUGINS=(
    ["Biometric"]="Biometric.git"
    ["Browser"]="Browser.git"
    ["Clipboard"]="Clipboard.git"
    ["Device"]="Device.git"
    ["Dialog"]="Dialog.git"
    ["FlashLight"]="Flashlight.git"
    ["Haptics"]="Haptics.git"
    ["Network"]="Network.git"
    ["Scanner"]="Scanner.git"
    ["Screen"]="Screen.git"
    ["SecureStorage"]="SecureStorage.git"
    ["Share"]="Share.git"
)

process_repo() {
    local repo_name="$1"
    local repo_dir="$2"
    
    echo ""
    echo "========================================"
    echo " Processing: $repo_name"
    echo "========================================"
    
    if [ ! -d "$repo_dir" ]; then
        echo "Directory $repo_dir does not exist. Skipping."
        return
    fi
    
    (
        cd "$repo_dir"
        
        # 1. Ensure remote origin URL is set correctly if URL provided
        if [ -n "$3" ]; then
            if git remote get-url origin >/dev/null 2>&1; then
                git remote set-url origin "$3"
            else
                git remote add origin "$3"
            fi
        fi
        
        # 2. Fetch all remotes
        git fetch origin || true
        
        # 3. Determine target branch (master or main)
        target_branch="master"
        if ! git show-ref --verify --quiet refs/heads/master && ! git ls-remote --exit-code --heads origin master >/dev/null 2>&1; then
            if git show-ref --verify --quiet refs/heads/main || git ls-remote --exit-code --heads origin main >/dev/null 2>&1; then
                target_branch="main"
            fi
        fi
        
        echo "--> Checking out branch '$target_branch'..."
        git checkout "$target_branch" 2>/dev/null || git checkout -b "$target_branch" "origin/$target_branch" 2>/dev/null || true
        
        echo "--> Pulling latest changes from origin/$target_branch..."
        git pull origin "$target_branch" || true
        
        echo "--> Deleting all local branches except '$target_branch'..."
        for branch in $(git branch | tr -d '*' | awk '{print $1}'); do
            if [ "$branch" != "master" ] && [ "$branch" != "main" ]; then
                echo "Deleting local branch: $branch"
                git branch -D "$branch" || true
            fi
        done
        
        echo "--> Repository state for $repo_name:"
        git branch -a
    )
}

# Process root Plugins repo
process_repo "Root Plugins Repo" "." "git@github.com:Wefters/Plugins.git"

# Process all submodules
for PLUGIN in "${!PLUGINS[@]}"; do
    process_repo "$PLUGIN" "$PLUGIN" "$remote_url/${PLUGINS[$PLUGIN]}"
done

echo ""
echo "========================================"
echo " All projects checked out to master, pulled, and cleaned!"
echo "========================================"
