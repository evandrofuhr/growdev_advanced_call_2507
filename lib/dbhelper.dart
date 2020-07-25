import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  final int _versao = 1;
  final String _nomeDB = 'todo.db';
  Database _db;
  static DBHelper _instancia = DBHelper._interno();
  factory DBHelper() {
    return _instancia;
  }
  DBHelper._interno();

  Future<Database> obtemDB() async {
    if (_db == null) {
      var _directory = await getApplicationDocumentsDirectory();
      var _path = join(_directory.path, _nomeDB);
      _db = await openDatabase(_path, version: _versao, onCreate: _onCreate);
    }
    return _db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
       create table todo (
            id integer primary key autoincrement,
            description text not null,
            done text not null default 'F',
            userid integer
        );
      ''');

    await db.execute('''
       create table user (
          id integer primary key, 
          nome text not null,
          email text not  null
        );
      ''');
  }
}
