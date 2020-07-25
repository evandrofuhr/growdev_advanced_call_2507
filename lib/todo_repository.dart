import 'package:call_2507/dbhelper.dart';
import 'package:call_2507/todo.dart';

class TodoRepository {
  final DBHelper _dbHelper = DBHelper();

  Future<bool> newTodo(Todo obj) async {
    var db = await _dbHelper.obtemDB();
    var rows = await db.insert('todo', obj.toMap());
    return rows > 0;
  }

  Future<bool> updateTodo(Todo obj) async {
    var db = await _dbHelper.obtemDB();
    var rows = await db
        .update('todo', obj.toMap(), where: 'id = ?', whereArgs: [obj.id]);
    return rows > 0;
  }

  Future<bool> deleteTodo(Todo obj) async {
    var db = await _dbHelper.obtemDB();
    var rows = await db.delete(
      'todo',
      where: 'id = ?',
      whereArgs: [obj.id],
    );
    return rows > 0;
  }

  Future<List<Todo>> getDoneTodos() async {
    var retorno = <Todo>[];
    var db = await _dbHelper.obtemDB();
    var result = await db.query(
      'todo',
      where: 'done = ?',
      whereArgs: ['T'],
    );
    if (result.isNotEmpty) {
      for (var todo in result) {
        retorno.add(Todo.fromMap(todo));
      }
    }
    return retorno;
  }
}
