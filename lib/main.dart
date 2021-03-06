
import 'package:assprovider/providerApp.dart';
import 'package:assprovider/task_model.dart';
import 'package:assprovider/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AddTask.dart';
import 'db_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
       create:(context){
       return AppProvider();
      },
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TabBarPage(),
      ),
    );
  }
}

class TabBarPage extends StatefulWidget{
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with SingleTickerProviderStateMixin {
  TabController tabController ;
  List<Task> tasks ;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context){
       return AppProvider();
      },
          child: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text('TodoList',style:TextStyle(fontWeight:FontWeight.bold,fontSize:28 ),),
          bottom: TabBar(
            controller: tabController,
            
            tabs: [
              Tab(
                text: 'All Tasks' ,
                
              ),Tab(
                text: 'Complete Tasks',

              ),Tab(
                text: 'Incomplete Tasks',

              ),
            ],
            isScrollable: true,),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                
                controller: tabController,
                children: [
                  AllTasks(tasks),
                  CompleteTasks(),
                  IncompleteTasks()],

              ),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
             MaterialPageRoute(
               builder: (context) => AddTask())),
          child: Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
       
        ),
      ),
    );
  }
}

class AllTasks extends StatefulWidget{

  List<Task> tasks ;
  AllTasks(this.tasks);

  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {

 myFun() {
    setState(() {

    });
  }

  deleteFun(e){
    setState(() {});
      Provider.of<AppProvider>(context, listen: false).deleteTasks(e);

  }

  Widget getTaskWidgets(List<Task> data){
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < data.length; i++){
      list.add(TaskWidget(data[i] , deleteFun , myFun));
    }
    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Task>>(
        future: Provider.of<AppProvider>(context, listen: false).selectAll(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            List<Task> data =snapshot.data;

            return ListView(
              children: [
                getTaskWidgets(data),
              ],
            );
          }
        },
      ),

      // ),
    );
  }


}class CompleteTasks extends StatefulWidget{
  @override
  _CompleteTasksState createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  myFun() {
    setState(() {

    });
  }

  deleteFun(e){
    setState(() {});
      Provider.of<AppProvider>(context, listen: false).deleteTasks(e);
  }

  Widget getTaskWidgets(List<Task> data){
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < data.length; i++){
      list.add(TaskWidget(data[i] , deleteFun , myFun));
    }
    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Task>>(
        future:Provider.of<AppProvider>(context, listen: false).selectspesific(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            List<Task> data =snapshot.data;
            return ListView(
              children: [
                getTaskWidgets(data),
              ],
            );
          }
        },
      ),
    );
  }

  
}class IncompleteTasks extends StatefulWidget{
  @override
  _IncompleteTasksState createState() => _IncompleteTasksState();
}

class _IncompleteTasksState extends State<IncompleteTasks> {
  myFun() {
    setState(() {

    });
  }

  deleteFun(e){
    setState(() {});
      Provider.of<AppProvider>(context, listen: false).deleteTasks(e);
  }

  Widget getTaskWidgets(List<Task> data){
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < data.length; i++){
      list.add(TaskWidget(data[i] , deleteFun , myFun));
    }
    return new Column(children: list);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: FutureBuilder<List<Task>>(
        future: Provider.of<AppProvider>(context, listen: false).selectspesifics(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );

          }else{
            List<Task> data =snapshot.data;
            return ListView(
              children: [

                getTaskWidgets(data),
              ],
            );
          }
        },
      ),
    );
  }
}


