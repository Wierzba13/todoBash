# ToDo bash app by Raul Wierzbiński
A console application intended for the arch linux family system.

#### Installation step by step for arch linux system family
* open terminal 
* go to home directory with:    cd ~
* clone repo with:  git clone https://github.com/Wierzba13/todoBash
* open .bashrc file with your favourite text editor:    sudo vim ~/.bashrc
* add line:     alias todo="sh ~/TODO_BASH/todo.sh"

Now 'todo' is alias for app. For help type: 'todo -h'


| Option        | Description           | 
| ------------- |:-------------:|
| -h, --help        |  show brief help |
| -v, --version        | display version of app      |
| -l, --list   | displays all tasks      |
| -a, --add [task content] | add task |
| -e, --edit [id] [new content] | edit task |
| -r, --remove [id] |  remove task |
| -c, --clear | remove all tasks |
