import 'package:flutter/material.dart';
import 'package:todo_app/data-access/todo-dao.dart';
import 'package:todo_app/models/todo_list_dto.dart';
import '../models/todo_item_dto.dart';
import '../utils/filter.dart';

class TodoListProvider with ChangeNotifier {
  TodoListDTO todoListDTO = TodoListDTO();
  TodoListDAO todoDAO = TodoListDAO();
  late Filter _filter = FilterAll();
  String _search = "";

  void applySearch(String search) {
    _search = search;
    notifyListeners();
  }

  void applyFilter(Filter filter) {
    _filter = filter;

    notifyListeners();
  }

  bool _getSearchText(TodoItemDTO todoItem) {
    if (_search.isEmpty) return true;

    return todoItem.title.contains(_search);
  }

  List<TodoItemDTO> get todoList {
    todoListDTO.sort();
    return todoListDTO.todoList
        .where((element) => _filter.filter(element) && _getSearchText(element))
        .toList();
  }

  TodoListProvider() {
    loadStorage();
  }
  void setItems(List<TodoItemDTO> todoList) {
    todoListDTO.setItems(todoList);
    notifyListeners();
  }

  TodoItemDTO findById(String id) {
    return todoListDTO.findById(id);
  }

  void handleCheckbox(String id, bool isDone) {
    todoListDTO.updateDone(id, isDone);

    todoDAO.updateDoneById(id, isDone);
    notifyListeners();
  }

  void addNewTodo(TodoItemDTO todoItem) {
    todoDAO.insert(todoItem);
    todoListDTO.add(todoItem);

    notifyListeners();
  }

  void removeTodo(TodoItemDTO todoItemDTO) {
    todoListDTO.remove(todoItemDTO);
    todoDAO.delete(todoItemDTO.id);

    notifyListeners();
  }

  loadStorage() {
    todoDAO.getTodoList().then((value) => {setItems(value)});
  }
}
