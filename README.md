## Hiptask

A hipster command line task applicaiton for me to put my newly learn ruby skills to practical use.


### Install

    gem install hiptask


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


### Tips

If you want to store you Hiptasks online, Dropbox is the easiest way

    hiptask config set tasks_list /path/to/Dropbox/hiptasks.txt


### Feedback

I do realise this code won't be the best as it's my very first ruby project. However, I will apreciate any feedback you can give me on the project or my Ruby skills in general.
