#!/bin/bash
# todo_list.sh

TODO_FILE="todo_list.txt"

# Create the file if it does not exist
touch $TODO_FILE

while true; do
    echo "To-Do List Manager"
    echo "1. View tasks"
    echo "2. Add task"
    echo "3. Remove task"
    echo "4. Exit"
    read -p "Choose an option: " choice

    case $choice in
        1) 
            echo "Tasks:"
            if [[ ! -s $TODO_FILE ]]; then
                echo "No tasks found."
            else
                # Display tasks with line numbers
                nl -w 2 -s ". " $TODO_FILE
            fi
            ;;
        2) 
            read -p "Enter task: " task
            echo "$task" >> $TODO_FILE
            echo "Task added."
            ;;
        3) 
            if [[ ! -s $TODO_FILE ]]; then
                echo "No tasks to remove."
            else
                nl -w 2 -s ". " $TODO_FILE
                read -p "Enter task number to remove: " num
                if [[ $num =~ ^[0-9]+$ && $num -le $(wc -l < $TODO_FILE) ]]; then
                    sed -i "${num}d" $TODO_FILE
                    echo "Task removed."
                else
                    echo "Invalid task number."
                fi
            fi
            ;;
        4) 
            echo "Goodbye!"
            break
            ;;
        *) 
            echo "Invalid option." 
            ;;
    esac
done
