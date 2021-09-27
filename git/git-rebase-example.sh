#!/usr/bin/bash

# Zak: Preparation
git init --bare repo

git clone repo zak
pushd zak
git config user.name zak
git config user.email zak@host

echo '1' > numbers.txt
git add numbers.txt
git commit -m 'initial commit'
git push origin
git log --pretty=format:"%h [%ci] <%an, %ae>: %s"

popd
read

# Alice
git clone repo alice
pushd alice
git config user.name alice
git config user.email alice@host

git checkout -b topic-alice
echo '2' >> numbers.txt
git add numbers.txt
git commit -m 'second commit'
git push --set-upstream origin topic-alice
git log --pretty=format:"%h [%ci] <%an, %ae>: %s"

popd
read

# Bob
git clone repo bob
pushd bob
git config user.name bob
git config user.email bob@host

git checkout topic-alice
git checkout -b topic-bob
echo '3' >> numbers.txt
git add numbers.txt
git commit -m 'third commit'
git push --set-upstream origin topic-bob
git log --pretty=format:"%h [%ci] <%an, %ae>: %s"

popd
read

# Mallory
git clone repo mallory
pushd mallory
git config user.name mallory
git config user.email mallory@host

git checkout topic-alice
git checkout -b topic-mallory
echo '3' >> numbers.txt
echo '4' >> numbers.txt
git add numbers.txt
git commit -m 'helping out'
git push --set-upstream origin topic-mallory
git log --pretty=format:"%h [%ci] <%an, %ae>: %s"

popd
read

# Alice (performing the problematic rebase)
pushd alice
git fetch origin
git rebase origin/topic-mallory
git push
git log --pretty=format:"%h [%ci] <%an, %ae>: %s"

popd
read

# Bob (suffering the consequences)
pushd bob
git fetch origin
git merge origin/topic-alice # XXX: this will cause a merge conflict

popd
read

rm -rf repo alice bob mallory zak
