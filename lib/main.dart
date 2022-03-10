import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/screens/home.dart';

import 'models/todo_item.dart';

List<TodoItem> todoList = [
  TodoItem(
      id: "1",
      title: "House Cleaning",
      description: "Quét dọn nhà",
      startTime: DateTime(2022),
      endTime: DateTime(2022),
      isDone: false),
  TodoItem(
      id: "2",
      title: "House Cleaning",
      description: "Quét dọn nhà",
      startTime: DateTime(2022),
      endTime: DateTime(2022),
      isDone: false),
  TodoItem(
      id: "3",
      title: "House Cleaning",
      description: "Quét dọn nhà",
      startTime: DateTime(2022),
      endTime: DateTime(2022),
      isDone: true),
];

class TodoListProvider with ChangeNotifier {
  final LocalStorage storage = LocalStorage('todo_app.json');

  late List<TodoItem> _todoList = [];
  List<TodoItem> get todoList {
    _todoList.sort((a, b) => a.isDone ? 1 : 0);
    return _todoList;
  }

  TodoListProvider() {
    _loadStorage();
  }

  void handleCheckbox(String id, bool isDone) {
    for (TodoItem item in _todoList) {
      if (item.id == id) {
        item.isDone = isDone;
        notifyListeners();
        _saveToStorage();
        break;
      }
    }
  }

  void addNewTodo(TodoItem todoItem) {
    _todoList.add(todoItem);
    _saveToStorage();
    notifyListeners();
  }

  _saveToStorage() {
    storage.setItem('todos', toJSONEncodable());
  }

  _loadStorage() {
    var items = storage.getItem('todos');
    print(items);
    if (items != null) {
      _todoList = List<TodoItem>.from(
        (items as List).map((item) => TodoItem(
            id: item['item'],
            title: item['title'],
            description: item['description'],
            startTime: DateTime.parse(item['startTime']),
            endTime: DateTime.parse(item['endTime']),
            isDone: item['isDone'])),
      );
    }
  }

  toJSONEncodable() {
    return todoList.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}

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
