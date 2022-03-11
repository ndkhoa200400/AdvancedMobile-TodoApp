import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/todo_item_dto.dart';

class TodoListDAO {
  Database? database;

  final databaseName = 'todo_app.db';
  Future open(String databasename) async {
    database = await openDatabase(join(await getDatabasesPath(), databasename),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          'create table Todo(id text primary key, title text, description text, starttime text, endtime text, isdone int)');
    });
  }

  void insert(TodoItemDTO item) async {
    await open(databaseName);
    await database?.insert('Todo', item.toJson());

    await close();
  }

  Future<List<TodoItemDTO>> getTodoList() async {
    await open(databaseName);
    final List<Map<String, dynamic>>? maps = await database?.query('Todo');

    await close();
    if (maps != null) {
      return List<TodoItemDTO>.from(
          maps.map((item) => TodoItemDTO.fromMap(item)));
    }
    return [];
  }

  void delete(String id) async {
    await open(databaseName);

    await database?.delete('Todo', where: 'id = ?', whereArgs: [id]);

    await close();
  }

  Future<int?> update(TodoItemDTO todo) async {
    return await database
        ?.update('Todo', todo.toJson(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<int?> updateDoneById(String id, bool isDone) async {
    await open(databaseName);
    int? count = await database?.rawUpdate(
        'UPDATE Todo SET isdone = ? where id = ?', [isDone ? 1 : 0, id]);
    await close();
    return count;
  }

  Future close() async => database?.close();
}
