#! /bin/bash

readonly tasks=tasks

printTasks() {
    if [ ${index:7:${#index}} -eq 0 ]
    then
        echo " "
        echo "There is not tasks to complete"
        echo "For help use -h or --help flag"
        echo " "
    else
        echo " "
        echo "TASKS LIST: "
        local i=0

        while IFS= read -r line
        do
            if [[ "$line" != "INDEX:"* ]]
            then
                echo $line
                (( i++ ))
            fi
        done < "./$tasks"
        echo " "
    fi
}
index=$(head -n 1 ./$tasks)
newIndex=0;
updateIndex() {
    newIndex=$(( ${index:7:${#index}}  + 1 ))

    overWrite="INDEX: $newIndex"
    sed -i "1s/.*/$overWrite/" $tasks

}

removeTask() {
    id=$1
    lineToDel=""
    echo ""
    lineDel="$(cat $tasks | grep -n "$id)" )"
    indexOfLineToDel=${lineDel:0:${#id}}
    indexOfLineToDel=${indexOfLineToDel//[:]/""}
    indS=$(( ${#indexOfLineToDel} + 1 ))
    ind=${lineDel:$indS:${#id}}
    if [[ $lineDel != "" ]] && [[ $lineDel == *":"* ]] && [[ $ind == $id ]]
    then
        echo "Task with ID=$id delete successfuly."
        sed -i.bak -e "${indexOfLineToDel}d" tasks
    else
        echo "There is not any task with this ID"
    fi
    echo ""
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
        echo "-l, --list                        displays all tasks"
        echo "-a, --add [task content]          add task"
        echo "-e, --edit                        edit task"
        echo "-r, --remove [id]                 remove task"
        echo "-c, --clear                       remove all tasks"
        echo ""
        exit 0
        ;;
    -l|--list)
        printTasks

        exit
        ;;
    -a|--add)
        echo " "
        echo "Task added successfuly. Content of added task: "
        cnt=0
        if (( $cnt == 1 ))
        then 
            break
        else
            updateIndex
            echo "$newIndex) ${@:2}"
            echo "$newIndex) ${@:2}" >> $tasks
            echo " "
            (( ctn++ )) 
        fi
        
        exit
        ;;
    -e|--edit)
        echo "ADD TASK"

        
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

        exit
        ;;
    *)
        echo "Unrecognized argument, type -h for list of options"
        exit
        break
        ;;
    esac
done