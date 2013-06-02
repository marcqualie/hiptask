## Hiptask

A hipster command line task applicaiton for me to put my newly learn ruby skills to practical use.


### Build Status

[![Build Status](https://travis-ci.org/marcqualie/hiptask.png?branch=master)](https://travis-ci.org/marcqualie/hiptask)


### Install (via rubygems.org)

    gem install hiptask


### Install (via git)

    git clone git@github.com:marcqualie/hiptask.git
    cd hiptask
    rake build
    rake install


### Usage

    hiptask # displays your task list
    hiptask help # full list of commands
    hiptask list # displays your task list
    hiptask add CONTENT # adds a new task
    hiptask do ID # marks a task as complete
    hiptask undo ID # reverts task to normal
    hiptask update ID CONTENT # update task content
    hiptask config [ACTION] [KEY] [VALUE] # manipulate config variables
    hiptask delete ID # deletes a task forever
    hiptask version # displays current version


### Tips &amp; Tricks

If you want to store you Hiptasks online, Dropbox is the easiest way

    hiptask config set tasks_file /path/to/Dropbox/hiptask.txt


### Roadmap

- Multiple Lists
- List sorting
- Meta Data
- Task Export/Import
- Database Storage (Obviously, Redis)
- Web UI


### Contributing

Patches and feature requests are more than welcome on [Github](https://github.com/marcqualie/hiptask) so feel free to fill up the issue board.
