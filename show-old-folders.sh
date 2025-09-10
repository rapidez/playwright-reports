#!/bin/bash
# Navigate to your repository
# Find folders in "rapidez" that are older than a month
git log --name-only --pretty=format: --diff-filter=A rapidez | awk '{print $1}' | sort | uniq | while read -r file; do
    folder=$(dirname "$file")
    last_commit_date=$(git log -1 --format="%ai" -- "$file")
    last_commit_epoch=$(date -d "$last_commit_date" +%s)
    one_month_ago=$(date -d "30 days ago" +%s)
    if [ "$last_commit_epoch" -lt "$one_month_ago" ]; then
        echo "$folder"
    fi
done
