import 'package:flutter/foundation.dart';
import 'package:todo_app/models/todo_item_dto.dart';

class TodoListDTO {
  final List<TodoItemDTO> _list = [];

  List<TodoItemDTO> get todoList => _list;

  void clear() {
    _list.clear();
  }

  void setItems(List<TodoItemDTO> items) {
    _list.clear();
    _list.addAll(items);
    sort();
  }

  void sort() {
    _list.sort((a, b) => a.endTime.isAfter(b.endTime) ? 0 : 1);
    _list.sort((a, b) => a.isDone ? 1 : 0);
  }

  add(TodoItemDTO item) {
    _list.add(item);
    sort();
  }

  remove(TodoItemDTO item) {
    _list.remove(item);
  }

  updateDone(String id, bool isDone) {
    for (TodoItemDTO item in todoList) {
      if (item.id == id) {
        item.isDone = isDone;

        break;
      }
    }
  }

  TodoItemDTO findById(String id) {
    return _list.firstWhere((element) => element.id == id);
  }

  void print() {
    _list.forEach((element) {
      debugPrint(element.toJson().toString());
    });
  }
}
