#!/bin/bash
# Navigate to your repository
# Find folders in "rapidez" that are older than a 14 days
git log --name-only --pretty=format: --diff-filter=A rapidez | awk '{print $1}' | sort | uniq | while read -r file; do
    folder=$(dirname "$file")
    last_commit_date=$(git log -1 --format="%ai" -- "$file")
    last_commit_epoch=$(date -d "$last_commit_date" +%s)
    old=$(date -d "14 days ago" +%s)
    if [ "$last_commit_epoch" -lt "$old" ]; then
        echo "$folder"
    fi
done
