# IRC

## Setup

Install `irssi` IRC client:

    # pacman -S irssi

## General Commands

Set nick name to "paedubucher":

    /nick paedubucher

Exit:

    /quit

## Connect

Show networks:

    /network list

Connect to network "OFTC":

    /connect oftc

## Identification

Getting help from the nick server:

    /msg NickServ help

Register with password and email:

    /msg NickServ REGISTER [password] [email]

Follow email instructions to verify the account, such as:

    /msg NickServ VERIFY REGISTER [nickname] [token]

Identify:

    /msg NickServ IDENTIFY [nickname] [password]

Group nick name to account:

    /msg NickServ GROUP

## Chatting

Join a channel:

    /join #openbsd

Leave a channel:

    /leave #openbsd
