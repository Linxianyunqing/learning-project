import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todoapplication/models/task_model.dart';



class TaskController extends GetxController{
  static var taskList = <Task>[].obs;
  
  @override
  void onInit(){
    super.onInit();
    openBox();
  }
  //open hive database of todoTasks box  
  void openBox()async{
    var box  = await Hive.openBox<Task>("todoTasks");
    taskList.addAll(box.values);
  }
  //add task to hive datebase
  void addTask(Task task)async{
    var box = Hive.box<Task>('todoTasks');
    await box.add(task);
    taskList.add(task);

  }
  //delete task to hive database
  static void deleteTask(int index){
    var box = Hive.box<Task>('todoTasks');
    box.deleteAt(index);
    taskList.remove(index);

  }
  //edit task to hive database
  void editTask(int index, Task newTask){
    var box = Hive.box<Task>('todoTasks');
    box.putAt(index, newTask);
    taskList[index] = newTask;

  }

  void toggleTaskCompletion (int index , Task newTask)async{
    taskList[index].isCompleted = !taskList[index].isCompleted;
    taskList.refresh();
  }
}