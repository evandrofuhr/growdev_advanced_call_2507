import 'package:call_2507/utils/dbhelper.dart';
import 'package:call_2507/models/user.dart';

class UserRepository {
  final DBHelper _dbHelper = DBHelper();

  Future<bool> newUser(User obj) async {
    var db = await _dbHelper.obtemDB();
    var rows = await db.insert('user', obj.toMap());
    return rows > 0;
  }

  Future<bool> updateUser(User obj) async {
    var db = await _dbHelper.obtemDB();
    var rows = await db
        .update('user', obj.toMap(), where: 'id = ?', whereArgs: [obj.id]);
    return rows > 0;
  }

  Future<bool> deleteUser(User obj) async {
    var db = await _dbHelper.obtemDB();
    var rows = await db.delete(
      'user',
      where: 'id = ?',
      whereArgs: [obj.id],
    );
    return rows > 0;
  }

  Future<List<User>> getUsers() async {
    var retorno = <User>[];
    var db = await _dbHelper.obtemDB();
    var result = await db.query('user');
    if (result.isNotEmpty) {
      for (var user in result) {
        retorno.add(User.fromMap(user));
      }
    }
    return retorno;
  }
}
