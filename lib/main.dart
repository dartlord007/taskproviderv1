import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:taskproviderv1/provider/taskprovider.dart";
import "package:taskproviderv1/screens/taskScreens.dart";

void main (){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) { return TaskViewmodel(); },
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TaskScreen(),
      ),
    );
  }
}