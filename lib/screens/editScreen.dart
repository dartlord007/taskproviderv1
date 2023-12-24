
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:taskproviderv1/model/taskmodel.dart";
import "package:taskproviderv1/provider/taskprovider.dart";

class EditScreen extends StatefulWidget {
  
  final Task note; //we dont want this to be empty, so we have to drag some value from the state or something. sha figure it out. 
  const EditScreen({super.key, required this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

    var textController;


    @override
    void initState() {
      textController = widget.note.taskName;
      super.initState(); 

    }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16,50,16,0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                IconButton(onPressed: (){ Navigator.pop(context);},
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: Colors.grey.shade800.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.arrow_back_ios_new)), 
                  color: Colors.white)
              ],
            ),

            Expanded(child: 
            ListView(
              children: [
                TextField(
                  controller: textController,
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                  decoration: const InputDecoration(
                    border:InputBorder.none,
                    hintText: "Edit your task...",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 30)
                  )
                ),

                
              ],
            ),)

          ],
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            updateTask(context, widget.note, textController);
          },
          elevation: 10,
          backgroundColor: Colors.grey.shade700,
          child: const Icon(Icons.save),
        ),

    );
  }
}

void updateTask(BuildContext context, Task note, TextEditingController textController) {
  final provider = Provider.of<TaskViewmodel>(context, listen: false);
  provider.updateTodo(note, textController.text);
    Navigator.of(context).pop();

  // if (note != null) {
  //   provider.updateTodo(note, textController.text);
  //   Navigator.of(context).pop();
  // } else {
  //   // Handle the case where 'note' is null, if needed
  //   print("Error: 'note' is null");
  // }
}

