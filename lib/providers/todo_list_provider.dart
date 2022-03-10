import 'package:flutter/material.dart';
import 'package:todo_app/data-access/todo-dao.dart';
import 'package:todo_app/models/todo_list_dto.dart';

import '../models/todo_item.dart';

class TodoListProvider with ChangeNotifier {
  TodoListDTO todoListDTO = TodoListDTO();
  TodoListDAO todoDAO = TodoListDAO();

  List<TodoItem> get todoList => todoListDTO.todoList;

  TodoListProvider() {
    loadStorage();
  }
  void setItems(List<TodoItem> todoList) {
    todoListDTO.setItems(todoList);
    notifyListeners();
  }

  void handleCheckbox(String id, bool isDone) {
    todoListDTO.updateDone(id, isDone);
    todoDAO.updateDoneById(id, isDone);
    notifyListeners();
  }

  void addNewTodo(TodoItem todoItem) {
    todoDAO.insert(todoItem);
    todoListDTO.add(todoItem);

    notifyListeners();
  }

  loadStorage() {
    todoDAO.getTodoList().then((value) => {setItems(value)});
  }
}
