#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

update_repo_master() {
    local repo_name="$1"
    local repo_dir="$2"
    
    echo ""
    echo "========================================"
    echo " Processing: $repo_name"
    echo "========================================"
    
    if [ ! -d "$repo_dir/.git" ] && [ ! -f "$repo_dir/.git" ]; then
        echo "Not a git repository: $repo_dir. Skipping."
        return
    fi
    
    (
        cd "$repo_dir"
        
        # 1. Fetch remotes
        git fetch origin || true
        
        # 2. Determine target branch (master or main)
        target_branch="master"
        if ! git show-ref --verify --quiet refs/heads/master && ! git ls-remote --exit-code --heads origin master >/dev/null 2>&1; then
            if git show-ref --verify --quiet refs/heads/main || git ls-remote --exit-code --heads origin main >/dev/null 2>&1; then
                target_branch="main"
            fi
        fi
        
        echo "--> Checking out branch '$target_branch'..."
        git checkout "$target_branch" 2>/dev/null || git checkout -b "$target_branch" "origin/$target_branch" 2>/dev/null || true
        
        echo "--> Pulling latest from origin/$target_branch..."
        git pull origin "$target_branch" || true
        
        echo "--> Deleting all local branches except '$target_branch'..."
        for branch in $(git branch | tr -d '*' | awk '{print $1}'); do
            if [ "$branch" != "master" ] && [ "$branch" != "main" ]; then
                echo "Deleting local branch: $branch"
                git branch -D "$branch" || true
            fi
        done
        
        echo "--> Current branches:"
        git branch -v
    )
}

# Update root repo
update_repo_master "Root Plugins Repo" "."

# Update all plugin submodules
for dir in */; do
    dir="${dir%/}"
    if [ -d "$dir/.git" ] || [ -f "$dir/.git" ]; then
        update_repo_master "$dir" "$dir"
    fi
done

echo ""
echo "========================================"
echo " Checkout, pull master, and branch cleanup complete for all projects!"
echo "========================================"
