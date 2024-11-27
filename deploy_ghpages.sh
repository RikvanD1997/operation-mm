#!/usr/bin/env bash

# Create a temporary directory to publish from
currentdir=$(pwd)
publishdir=$(mktemp -d -p "$currentdir" 2>/dev/null || mktemp -d -p "$currentdir" -t "publish")
if [[ ! "$publishdir" || ! -d "$publishdir" ]]; then
	echo "Couldn't create temporary directory $publishdir"
	exit 1
else
	echo "Created temporary directory $publishdir"
fi

# This cleeanup trap function ensures the temporary directory and its associated
# git worktree are cleaned up.
function cleanup {
	cd "$currentdir"
	rm -r "$publishdir"
	echo "Deleted temporary directory $publishdir"
	git worktree prune
	git worktree list
}
trap cleanup EXIT

### Actual deployment script below

git worktree add "$publishdir" publish --no-checkout

git worktree list

cp -r dist/* "$publishdir"

cd $publishdir
git add .
git commit -m "Publishing at $(date)"

git push origin publish
