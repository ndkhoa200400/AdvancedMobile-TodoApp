import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/providers/todo_list_provider.dart';
import 'package:todo_app/screens/home.dart';

import 'models/todo_item_dto.dart';

List<TodoItemDTO> todoList = [
  TodoItemDTO(
      id: "1",
      title: "House Cleaning",
      description: "Quét dọn nhà",
      startTime: DateTime(2022),
      endTime: DateTime(2022),
      isDone: false),
  TodoItemDTO(
      id: "2",
      title: "House Cleaning",
      description: "Quét dọn nhà",
      startTime: DateTime(2022),
      endTime: DateTime(2022),
      isDone: false),
  TodoItemDTO(
      id: "3",
      title: "House Cleaning",
      description: "Quét dọn nhà",
      startTime: DateTime(2022),
      endTime: DateTime(2022),
      isDone: true),
];

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => todoList),
        ChangeNotifierProvider<TodoListProvider>(
          create: (_) => TodoListProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          backgroundColor: AppColors.background),
      home: const HomeScreen(),
    );
  }
}
