import 'package:assprovider/providerApp.dart';
import 'package:assprovider/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'db_helper.dart';

class TaskWidget extends StatefulWidget{
  Task task;
  Function fun;
  Function fun1 ;
  TaskWidget(this.task ,[this.fun1 , this.fun] );

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context){
       return AppProvider();
      },
          child: Card(
        shadowColor: Colors.blueAccent,
        margin: EdgeInsets.all(5),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: Icon(Icons.delete,), onPressed: (){

                showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(title: Text("Delete Task")
                  ,content: Text("Delete a task"),
                  actions: <Widget>[
                  FlatButton(child: Text("Ok"), onPressed:() {
                    widget.fun1(widget.task);
                    Navigator.of(context).pop();
                  }
                  ),
                  FlatButton(child: Text("Canal"), onPressed:(){
                    Navigator.of(context).pop();

                  })
                  ]
                  );
                });

              }),

              Text(widget.task.taskName),

              Checkbox(
                  value: widget.task.isComplete,
                  onChanged: (value){
                   Provider.of<AppProvider>(context, listen: false).updateOnTasks(
                   widget.task.id,widget.task.taskName,this.widget.task.isComplete =!this.widget.task.isComplete);
                    setState(() {});
                    widget.fun();
                  })
            ],
          ),
        ),
      ),
    );
  }
}