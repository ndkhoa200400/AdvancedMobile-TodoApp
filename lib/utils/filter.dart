import '../models/todo_item_dto.dart';

abstract class Filter {
  bool filter(TodoItemDTO todoItem);
}

class FilterAll extends Filter {
  @override
  bool filter(TodoItemDTO todoItem) {
    return true;
  }
}

class FilterUpcoming extends Filter {
  @override
  bool filter(TodoItemDTO todoItem) {
    if (!todoItem.isDone && todoItem.endTime.isAfter(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }
}

class FilterDone extends Filter {
  @override
  bool filter(TodoItemDTO todoItem) {
    return todoItem.isDone;
  }
}

class FilterToday extends Filter {
  bool isToday(DateTime date) {
    final now = DateTime.now();

    return now.day == date.day &&
        now.month == date.month &&
        now.year == date.year;
  }

  @override
  bool filter(TodoItemDTO todoItem) {
    if (!todoItem.isDone && isToday(todoItem.endTime)) {
      return true;
    } else {
      return false;
    }
  }
}
