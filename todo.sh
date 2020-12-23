#! /bin/bash

readonly tasks="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/tasks"

printTasks() {
    if [[ ${index:7:${#index}} -eq 0 ]]
    then
        echo "There is not tasks to complete"
        echo "For help use -h or --help flag"
    else
        echo "TASKS LIST: "
        local i=0

        while IFS= read -r line
        do
            if [[ "$line" != "INDEX:"* ]]
            then
                echo $line
                (( i++ ))
            fi
        done < "$tasks"
    fi
}

index=$(head -n 1 $tasks)
newIndex=0;
updateIndex() {
    newIndex=$(( ${index:7:${#index}}  + 1 ))

    overWrite="INDEX: $newIndex"
    sed -i "1s/.*/$overWrite/" $tasks

}

removeTask() {
    id=$1
    lineToDel=""
    lineDel="$(cat $tasks | grep -n "$id)" )"
    indexOfLineToDel=${lineDel:0:${#id}}
    indexOfLineToDel=${indexOfLineToDel//[:]/""}
    indS=$(( ${#indexOfLineToDel} + 1 ))
    ind=${lineDel:$indS:${#id}}
    if [[ $lineDel != "" ]] && [[ $lineDel == *":"* ]] && [[ $ind == $id ]]
    then
        echo "Task with ID=$id delete successfuly."
        sed -i.bak -e "${indexOfLineToDel}d" $tasks
    else
        echo "There is not any task with this ID"
    fi
}

if [ $# -eq 0 ]
then
    printTasks
fi

while [ $# -gt 0 ]; do
    case "$1" in
    -h|--help)
        echo "
            _______    _____
           |__   __|  |  __ \
              | | ___ | |  | | ___
              | |/ _ \| |  | |/ _ \
              | | (_) | |__| | (_) |
              |_|\___/|_____/ \___/
        "

        echo "Options ( in []  you must type data ):"
        echo "-h, --help                        show brief help"
        echo "-v, --version                     display version of app"
        echo "-l, --list                        displays all tasks"
        echo "-a, --add [task content]          add task"
        echo "-e, --edit [id] [new content]     edit task"
        echo "-r, --remove [id]                 remove task"
        echo "-c, --clear                       remove all tasks"
        echo ""

        exit 0
        ;;
    -v|--version)
        echo "Version 1.0.0"
        echo "Created by Raul Wierzbiński 2020"

        exit 0
        ;;
    -l|--list)
        printTasks

        exit
        ;;
    -a|--add)
        cnt=0
        if (( $cnt == 1 ))
        then
            break
        else
            if [[ ${@:2} != "" ]]
            then
                echo "Task added successfuly. Content of added task: "
                updateIndex
                echo "$newIndex) ${@:2}"
                echo "$newIndex) ${@:2}" >> $tasks
                (( ctn++ ))
            else
                echo "You can't add empty task"
            fi
        fi

        exit
        ;;
    -e|--edit)
        idEdit=$2
        content=${@:3}
        prevContent=""

        while IFS= read -r line
        do
            if [[ "$line" == "$idEdit)"* ]]
            then
                prevContent=$line
            fi
        done < "$tasks"

        if [[ $prevContent != "" ]]
        then
            if [[ $content != "" ]]
            then
                sed -i -e "s/$prevContent/$idEdit) $content/" "$tasks"
            else
                echo "New content of task can't be empty"
            fi
        else
            echo "Task with this ID was not found"
        fi



        exit
        ;;
    -r|--remove)
        if [[ $2 != "" ]]
        then
            removeTask $2
        else
            echo "Enter the ID"
        fi

        exit
        ;;
    -c|--clear)
        echo "INDEX: 0" > $tasks
        echo "All tasks have been deleted"

        exit
        ;;
    *)
        echo "Unrecognized argument, type -h for list of options"

        exit
        break
        ;;
    esac
done