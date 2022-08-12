# Clean all local branches of all repos in the directory.

#!/bin/bash
cwd=$(pwd)
for i in */.git
do
echo "🧹 Cleaning local branches of ${i}..."
cd $i/..
branch=$(git symbolic-ref --short -q HEAD)
echo "Current branch: ${branch}"
git checkout develop -q || git checkout main -q || git checkout master -q
git branch | grep -v "develop" | grep -v "main" | grep -v "master" | xargs --no-run-if-empty git branch -D
echo "✔️  Done: ${i}."
git checkout $branch -q
cd $cwd
done
