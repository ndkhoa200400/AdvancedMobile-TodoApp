import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/providers/todo_list_provider.dart';
import 'package:todo_app/screens/calendar_sceen.dart';
import 'package:todo_app/screens/detailed_todo.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/service/navigation_service.dart';
import 'package:todo_app/service/service_locator.dart';

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
  setupServiceLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoListProvider>(
          create: (_) => TodoListProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: getIt<NavigationService>().navigatorKey,
        onGenerateRoute: (routeSettings) {
          routeSettings.arguments;
          switch (routeSettings.name) {
            case 'detailed-todo':
          }
          return MaterialPageRoute(
              builder: (context) => DetailedTodoScreen.id(
                    id: routeSettings.arguments as String,
                  ));
        },
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue, backgroundColor: AppColors.background),
        home: const HomeScreen(),
        routes: {
          "/home": (context) => const HomeScreen(),
          "/calendar-screen": (context) => const CalendarScreen()
        });
  }
}
