import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todoapplication/controller/task_controller.dart';
import 'package:todoapplication/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {

  final Task  ? task;
  final int ? index;
  const AddTaskScreen({
    super.key,
    this.index,
    this.task
    });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  
  final TaskController taskController = Get.find();

  final TextEditingController  titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime? selectedDate;

  @override
  void initState() {
    // TODO: implement reassemble
    super.initState();
    if(widget.task != null){
      titleController.text = widget.task!.title; 
      descriptionController.text = widget.task!.description;
      selectedDate = widget.task!.dueDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    //一个页面同时实现添加或者编辑任务
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.task != null ? "Edit Task" : "Add New Task",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Task Title",
              style:  TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            //设置输入文字的区域
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter Task Title",
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "Task Description",
              style:  TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            //设置输入文字的区域
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter Task Descrption",
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "Due Date",
              style: TextStyle(fontWeight: FontWeight.w500,),
            ),
            SizedBox(height: 10),
            TextButton.icon(
              label:Text(
                selectedDate == null 
                  ? "Pick a Due Date" 
                  : '${selectedDate!.toLocal()}'.split(' ')[0],
                ), 
              icon: Icon(
                Icons.calendar_month_rounded,
                color: Colors.deepPurple,
                ),
               onPressed: () async{
                selectedDate = await showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2024), 
                  lastDate: DateTime(2100)
                );
                setState(() {
                });
              },
            ),
            SizedBox(height: 30,),
            //设置“ADDTASK”按钮
            Center(
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF493AD5),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 50 , 
                    vertical: 15
                    ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )
                ) ,
                child: Text(
                  widget.task != null
                    ? "Uptade Task"
                    : "Add Task"
                  ),
                onPressed:() {
                  //检测输入框里内容是否为空
                  if(titleController.text.isEmpty || descriptionController.text.isEmpty || selectedDate == null){
                    Get.snackbar(
                      "Error" , "Please fill in all fields",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  //编辑/更新任务
                  if(widget.task != null){
                    var updateTask = Task(
                      title: titleController.text,
                      description: descriptionController.text ,
                      dueDate: selectedDate!,
                      isCompleted: widget.task!.isCompleted,
                      );
                    taskController.editTask(widget.index!, updateTask );
                    Get.back();
                    Get.snackbar(
                      "Success", "Task Added Successfully",
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  }else{
                    //添加新任务
                    var newTask = Task(
                      title: titleController.text,
                      description: descriptionController.text ,
                      dueDate: selectedDate!,
                      //isCompleted: widget.task!.isCompleted,
                      );
                    taskController.addTask(newTask);
                    Get.back();
                    Get.snackbar(
                      "Success", "Task Added Successfully",
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );

                  }
                },
              ),
            )
          ],
        )
      ),
      
    );
  }
}