
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskproviderv1/constants/constants.dart';
import 'package:taskproviderv1/model/taskmodel.dart';
import 'package:taskproviderv1/provider/taskprovider.dart';
import 'package:taskproviderv1/screens/editScreen.dart';
import 'package:taskproviderv1/widgets/dialog.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      appBar: AppBar(
        backgroundColor: primary,
        title: const Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              "Task Manager",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Consumer<TaskViewmodel>(builder: (context, taskProvider, _) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              return TaskWidget(
                task: task,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: primary,
                height: 1,
                thickness: 1,
              );
            },
            itemCount: taskProvider.tasks.length);
      }),
      floatingActionButton: const AddTaskButton(),
    );
  }
}

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditScreen(note: task)),
            );},
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      title: Text(
        task.taskName,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        "${task.date}, ${task.time}",
        style: const TextStyle(color: textBlue),
      ),
      trailing: IconButton(onPressed: ()async {
        final result = await confirmDialog(context);
        if (result!=null && result )
          {return deleteTodo(context,task );}
        },
         icon: const Icon(Icons.delete),),
    );
  }

  Future<dynamic> confirmDialog(BuildContext context) {
    return showDialog(
                          context: context,
                          builder: (BuildContext context)  {                      
                          return AlertDialog (
                            backgroundColor: Colors.grey.shade900,
                            icon: Icon(Icons.info, color: Colors.grey.shade700,),
                            title: const Text("Are you sure you want to delete this", style: TextStyle(color: Colors.white ),),

                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                              ElevatedButton(onPressed: (){
                                Navigator.pop(context, true);
                              }, 
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                              child: const SizedBox(
                                width: 50,
                                height: 20,
                                child: Text("Yes", 
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white ),),
                              )),

                              ElevatedButton(onPressed: (){
                                Navigator.pop(context, false);
                              }, 
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              child: const SizedBox(
                                width: 50,
                                height: 20,
                                child: Text("No", 
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white ),),
                              )),
                            ]),

                          );
                          });
  }
}

void deleteTodo(BuildContext context, Task todo) {
    final provider = Provider.of<TaskViewmodel>(context, listen: false);
    provider.removeTodo(todo);
}

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const DialogBox();
          },
        );
      },
      child: const Icon(
        Icons.add,
        size: 40,
      ),
    );
  }
}

