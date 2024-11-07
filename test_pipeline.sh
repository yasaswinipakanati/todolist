#!/bin/bash
# This script tests the functionality of the todo_list.sh application.

TODO_FILE="todo_list.txt"
LOG_FILE="test_pipeline_results.log"
rm -f $TODO_FILE

# Test Add Task
echo "Adding task..." >> $LOG_FILE
echo "Test Task 1" | ./todo_list.sh << EOF
2
EOF
grep -q "Test Task 1" $TODO_FILE && echo "Add Task Passed" >> $LOG_FILE || echo "Add Task Failed" >> $LOG_FILE

# Test View Task
echo "Viewing tasks..." >> $LOG_FILE
./todo_list.sh << EOF | grep -q "Test Task 1"
1
EOF
[[ $? -eq 0 ]] && echo "View Task Passed" >> $LOG_FILE || echo "View Task Failed" >> $LOG_FILE

# Test Remove Task
echo "Removing task..." >> $LOG_FILE
./todo_list.sh << EOF
3
1
EOF
! grep -q "Test Task 1" $TODO_FILE && echo "Remove Task Passed" >> $LOG_FILE || echo "Remove Task Failed" >> $LOG_FILE

rm -f $TODO_FILE

