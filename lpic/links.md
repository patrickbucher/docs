# Links

- inode: index node (file attributes)
- symbolic links (soft links): reference to a file
    - has its own inode and permissions, but permissions of target restrict
      access
    - relative links may break when moving them around (better use absolute
      links)
- hard links: additional name for an inode
    - only work for files
    - only work within the same file system

create a hard link:

    ln TARGET LINK

or, in a different directory, leave away the link name

    cd foo
    ln ../bar.txt # creates bar.txt

list files with inodes (hard link has the same inode as original file):

    ls -i

list with link number (second column):

    ls -l

create a symbolic link:

    ln -s TARGET LINK
    ln -s ../TARGET

the permissions start with an `l`

    ls -li link
    3050278 lrwxrwxrwx [...]
