#!/bin/bash

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "Checking git repositories in current directory..."
echo "=================================================="

# Loop through all immediate subdirectories
for dir in */; do
    # Remove trailing slash
    dir=${dir%/}
    
    # Check if it's a git repository
    if [ -d "$dir/.git" ] || [ -f "$dir/.git" ]; then
        echo -e "\n${BLUE}Repository: $dir${NC}"
        
        # Change to the directory
        cd "$dir" || continue
        
        # Check for uncommitted changes
        if [ -n "$(git status --porcelain)" ]; then
            echo -e "${RED}✗ Uncommitted changes:${NC}"
            git status --short
        else
            echo -e "${GREEN}✓ No uncommitted changes${NC}"
        fi
        
        # Check for unpushed commits
        LOCAL=$(git rev-parse @ 2>/dev/null)
        REMOTE=$(git rev-parse @{u} 2>/dev/null 2>/dev/null)
        BASE=$(git merge-base @ @{u} 2>/dev/null)
        
        if [ $? -eq 0 ]; then  # If remote branch exists
            if [ "$LOCAL" = "$REMOTE" ]; then
                echo -e "${GREEN}✓ All commits pushed${NC}"
            elif [ "$LOCAL" = "$BASE" ]; then
                echo -e "${RED}✗ Need to pull (behind remote)${NC}"
            elif [ "$REMOTE" = "$BASE" ]; then
                echo -e "${RED}✗ Need to push (ahead of remote)${NC}"
            else
                echo -e "${RED}✗ Diverged from remote${NC}"
            fi
            
            # Show actual commit counts
            AHEAD=$(git rev-list --count @{u}..@ 2>/dev/null)
            BEHIND=$(git rev-list --count @..@{u} 2>/dev/null)
            
            if [ "$AHEAD" -gt 0 ] || [ "$BEHIND" -gt 0 ]; then
                echo -e "${YELLOW}  Details: ahead by $AHEAD, behind by $BEHIND${NC}"
            fi
        else
            echo -e "${YELLOW}⚠ No remote tracking branch${NC}"
        fi
        
        # Check for stashes
        if [ -n "$(git stash list)" ]; then
            STASH_COUNT=$(git stash list | wc -l)
            echo -e "${YELLOW}⚠ Has $STASH_COUNT stash(es)${NC}"
        fi
        
        # Return to original directory
        cd - > /dev/null || exit
    else
        echo -e "\n${YELLOW}Skipping $dir (not a git repository)${NC}"
    fi
done

echo -e "\n=================================================="
echo "Git check complete!"
