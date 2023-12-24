import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:taskproviderv1/constants/constants.dart";
import "package:taskproviderv1/provider/taskprovider.dart";
import "package:taskproviderv1/widgets/customText.dart";


class DialogBox extends StatelessWidget {
  const DialogBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    final taskProvider = Provider.of<TaskViewmodel>(context, listen: false);
    return Dialog(
      backgroundColor: secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
      child: SizedBox(
        height: screenHeight * 0.5,
        width: screenWidth * 0.8,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Add Task",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Task",
                style: TextStyle(color: textBlue),
              ),
              CustomText(
                hint: "Enter a Task",
                onChanged: (value) {
                  taskProvider.setTaskName(value);
                },
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Due Date",
                style: TextStyle(color: textBlue),
              ),
              CustomText(
                hint: "Enter a Date",
                readOnly: true,
                icon: Icons.calendar_month,
                controller: taskProvider.dateCont,
                onTap: () async {
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2017),
                      lastDate: DateTime(2030));

                  taskProvider.setDate(date);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                hint: "Enter a Time",
                readOnly: true,
                icon: Icons.timer,
                controller: taskProvider.timeCont,
                onTap: () async {
                  TimeOfDay? time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());

                  taskProvider.settime(time);
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () async {
                      await taskProvider.addTask();
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(color: primary),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}