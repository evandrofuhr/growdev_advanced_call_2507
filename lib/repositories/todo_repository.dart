import 'package:call_2507/models/user.dart';
import 'package:call_2507/utils/dbhelper.dart';
import 'package:call_2507/models/todo.dart';

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

  Future<List<Todo>> getTodos({int userId = 0}) async {
    var retorno = <Todo>[];
    var db = await _dbHelper.obtemDB();

    var _sql = '''
      select 
        todo.*, 
        user.nome as username
      from 
        todo
      left join user on user.id = todo.userid
      where
        1=1
    ''';

    if (userId > 0) {
      _sql += 'and (todo.userid is null or todo.userid = ?)';
    }
    _sql += 'order by todo.id desc';

    List<Map<String, dynamic>> result;

    if (userId > 0) {
      result = await db.rawQuery(_sql, [userId]);
    } else {
      result = await db.rawQuery(_sql);
    }
    if (result.isNotEmpty) {
      for (var todo in result) {
        retorno.add(Todo.fromMap(todo));
      }
    }
    return retorno;
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
