This example should demonstrate a possible issue when using `git rebase` on
commits that have already been published.

# Zak's Preparation

First, a local bare repository is created by `zak`:

```bash
zak@host$ cd /tmp
zak@host$ git init --bare repo
```

Zak clones the repo, performs some work, which he commits and pushes back to the
`origin`:

```bash
zak@host$ git clone repo zak
zak@host$ cd zak

zak@host$ echo '1' > numbers.txt
zak@host$ git add numbers.txt
zak@host$ git commit - 'initial commit'
zak@host$ git push origin

zak@host$ git log --pretty=format:"%h [%ci] <%an, %ae>: %s"
aef6e42 [2021-09-27 22:03:33 +0200] <zak, zak@host>: initial commit
```

# Alice's Branch

Alice clones the repo, too. On a branch `topic-alice`, she performs some work on
it, too, then commits and pushes:

```bash
alice@host$ cd /tmp
alice@host$ git clone repo alice
alice@host$ cd alice
alice@host$ git checkout -b topic-alice

alice@host$ echo '2' >> numbers.txt
alice@host$ git add numbers.txt
alice@host$ git commit -m 'second commit'
alice@host$ git push --set-upstream origin topic-alice

alice@host$ git log --pretty=format:"%h [%ci] <%an, %ae>: %s"
311aa81 [2021-09-27 22:14:29 +0200] <alice, alice@host>: second commit
aef6e42 [2021-09-27 22:03:33 +0200] <zak, zak@host>: initial commit
```

# Bob's Branch

Bob joins Alice into her efforts. He clones the repository, and creates his own
branch `topic-bob` based on alice's branch `topic-alice`:

```bash
bob@host$ cd /tmp
bob@host$ git clone repo bob
bob@host$ cd bob
bob@host$ git checkout topic-alice
bob@host$ git checkout -b topic-bob

bob@host$ echo '3' >> numbers.txt
bob@host$ git add numbers.txt
bob@host$ git commit -m 'third commit'
bob@host$ git push --set-upstream origin topic-bob

bob@host$ git log --pretty=format:"%h [%ci] <%an, %ae>: %s"
c258f24 [2021-09-27 22:19:13 +0200] <bob, bob@host>: third commit
311aa81 [2021-09-27 22:14:29 +0200] <alice, alice@host>: second commit
aef6e42 [2021-09-27 22:03:33 +0200] <zak, zak@host>: initial commit
```

# Mallory's Modification

At roughly the same time as Bob, but unaware of him, Mallory also starts working
on the repository, but directly on the `master` branch:

```bash
mallory@host$ cd /tmp
mallory@host$ git clone repo mallory
mallory@host$ cd mallory

mallory@host$ echo '2' >> numbers.txt
mallory@host$ echo '3' >> numbers.txt
mallory@host$ echo '4' >> numbers.txt
mallory@host$ git add numbers.txt
mallory@host$ git commit -m 'helping out'
mallory@host$ git push

mallory@host$ git log --pretty=format:"%h [%ci] <%an, %ae>: %s"
8c04282 [2021-09-27 22:23:37 +0200] <mallory, mallory@host>: helping out
aef6e42 [2021-09-27 22:03:33 +0200] <zak, zak@host>: initial commit
```

# Alice's Mistake

Alice, becoming aware of Mallory's modifications, incorporates them into her own
branch, rewriting the commit history in the process:

```bash
alice@host$ git fetch origin
alice@host$ git rebase origin/master
```

TODO: see script
