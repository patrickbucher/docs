#!/usr/bin/bash

# Zak: Preparation
cd /tmp
git init --bare repo

git clone repo zak
cd zak
git config user.name zak
git config user.email zak@host

echo '1' > numbers.txt
git add numbers.txt
git commit -m 'initial commit'
git push origin
git log --pretty=format:"%h [%ci] <%an, %ae>: %s"

sleep 2

# Alice
cd /tmp
git clone repo alice
cd alice
git config user.name alice
git config user.email alice@host

git checkout -b topic-alice
echo '2' >> numbers.txt
git add numbers.txt
git commit -m 'second commit'
git push --set-upstream origin topic-alice
git log --pretty=format:"%h [%ci] <%an, %ae>: %s"

sleep 2

# Bob
cd /tmp
git clone repo bob
cd bob
git config user.name bob
git config user.email bob@host

git checkout topic-alice
git checkout -b topic-bob
echo '3' >> numbers.txt
git add numbers.txt
git commit -m 'third commit'
git push --set-upstream origin topic-bob
git log --pretty=format:"%h [%ci] <%an, %ae>: %s"

sleep 2

# Mallory
cd /tmp
git clone repo mallory
cd mallory
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

sleep 2

# Alice
cd /tmp/alice
git fetch origin
git rebase origin/topic-mallory
git push
git log --pretty=format:"%h [%ci] <%an, %ae>: %s"

sleep 2

# Bob
cd /tmp/bob
git fetch origin
git merge origin/topic-alice # XXX: this will cause a merge conflict
