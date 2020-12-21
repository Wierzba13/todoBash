#! /bin/bash

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
        done < "./tasks.txt"
        echo " "
    fi
}
index=$(head -n 1 ./tasks.txt)
newIndex=0;
updateIndex() {
    newIndex=$(( ${index:7:${#index}}  + 1 ))

    overWrite="INDEX: $newIndex"
    sed -i "1s/.*/$overWrite/" tasks.txt

}

if [ $# -eq 0 ] 
then 
    printTasks
fi

while true && [ $# -gt 0 ]; do
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
        
        echo "Options:"
        echo "-h, --help            show brief help"
        echo "-l, --list           displays all tasks"
        echo "-a, --add             add task"
        echo "-e, --edit            edit task"
        echo "-r, --remove          remove task"
        echo "-c, --clear           remove all tasks"
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
            echo "$newIndex) ${@:2}" >> tasks.txt
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
        echo "ADD TASK"

        
        exit
        ;;
    -c|--clear)
        echo "INDEX: 0" > tasks.txt

        
        exit
        ;;
    *)
        echo "Unrecognized argument, type -h for list of options"
        exit
        break
        ;;
    esac
done


# echo elo >> tasks.txt







# declare -A myArr
# myArr[indx1]="SIEMAA"
# myArr[indx2]="ELO"
# myArr[indx3]="BENC"
# myArr[indx4]="HEHE"
# echo ${myArr[indx1]}
