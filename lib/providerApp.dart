
import 'package:assprovider/task_model.dart';
import 'package:flutter/material.dart';

import 'db_helper.dart';

class AppProvider extends ChangeNotifier{
  int id;
  String taskName;
  bool isComplete = false;
  List<Task> tasks;
  
 
  
  insertTask(int id,String taskName,bool isComplete){
    this.id = id ;
    this.taskName = taskName;
    this.isComplete = isComplete;
        DBHelper.dbHelper.insertNewTask(Task(taskName,isComplete,id));

    notifyListeners();
  }

  deleteTasks(Task) async {
    DBHelper.dbHelper.deleteTask(Task);
    notifyListeners();
  }

  updateOnTasks(int id, String taskName, bool isComplete) {
    this.id = id;
    this.taskName = taskName;
    this.isComplete = isComplete;
   DBHelper.dbHelper.updateTask(Task(taskName, isComplete, id));
    notifyListeners();
  }

    selectAll(){
    return DBHelper.dbHelper.selectAllTasks();
    notifyListeners();
  }

     selectspesific(){
    return  DBHelper.dbHelper.selectSpecificTask(1);
    notifyListeners();
  }
  
      selectspesifics(){
    return  DBHelper.dbHelper.selectSpecificTask(0);
    notifyListeners();
  }

}