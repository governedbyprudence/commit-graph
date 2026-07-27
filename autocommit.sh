FILE="~/commit-graph/activity.log"

git -C ~/commit-graph/ pull origin main --quiet

# Append a random line to a log file so there's an actual diff
echo "$(date '+%Y-%m-%d %H:%M:%S') - $(head -c 16 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9' | head -c 12)" >> "$HOME/commit-graph/activity.log"

git -C ~/commit-graph/ add .

if ! git -C ~/commit-graph/ diff --cached --quiet; then
  git -C ~/commit-graph/ commit -m "chore: update log $(date '+%Y-%m-%d %H:%M')"
  git -C ~/commit-graph/ push origin main --quiet
  echo "$(date): committed" >>  ~/commit-graph/commit_script.log
else
  echo "$(date): nothing to commit" >>  ~/commit-graph/commit_script.log
fi
