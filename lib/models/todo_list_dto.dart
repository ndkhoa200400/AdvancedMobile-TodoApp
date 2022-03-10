import 'package:todo_app/models/todo_item.dart';

class TodoListDTO {
  List<TodoItem> _list = [];

  List<TodoItem> get todoList => _list;

  void clear() {
    _list.clear();
  }

  void setItems(List<TodoItem> items) {
    _list.clear();
    _list.addAll(items);
    sort();
  }

  void sort() {
    _list.sort((a, b) => a.isDone ? 1 : 0);
  }

  add(TodoItem item) {
    _list.add(item);
  }

  remove(TodoItem item) {
    _list.remove(item);
  }

  updateDone(String id, bool isDone) {
    for (TodoItem item in todoList) {
      if (item.id == id) {
        item.isDone = isDone;

        break;
      }
    }
  }
}
