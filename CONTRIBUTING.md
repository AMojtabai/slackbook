# Contributing

This project is a community update of the Revised Slackware Book
(originally by Alan Hicks and others, based on "Slackware Linux
Essentials"). It targets Slackware 15.0. Your contributions are greatly appreciated.

## Licenses

All contributions are licensed under Creative Commons
Attribution-ShareAlike 3.0 Unported (see `COPYING`). By opening a pull
request you agree to this. Only submit work you wrote yourself or that
is under a compatible license. Do not paste text from other books,
websites, or man pages beyond short quoted examples.


## Setup

1. Fork this repository and clone your fork
2. Set your own identity

       git config user.name "Your Name"
       git config user.email "email@example.com"

3. Add the original as a remote so you can stay current

       git remote add upstream https://github.com/AMojtabai/slackbook.git
4. Branch from `slackware-15.0`, not `master`. `master` is the frozen 2012 snapshot. Do not open pull requests against it.


## Commits

Try to keep your commits small.

    git add <file>
    git commit

Commit message format:

    One line summary.

## Pull requests

1. Push your branch to your fork

       git push -u origin <branch-name>

2. Open a pull request against `slackware-15.0`.
3. Describe what you changed, which chapter it affects, and how you tested it.
4. Be ready to revise it after review. 


## Reporting issues

Open an issue for outdated text, mistakes, or things that are missing. Say which chapter and which section is wrong.
