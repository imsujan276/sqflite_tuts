import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'models/todo.dart';

class DatabaseHelper {
  //Here creating singleton object
  static DatabaseHelper _databaseHelper = DatabaseHelper._();
  DatabaseHelper._();
  factory DatabaseHelper() => _databaseHelper;

  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      return await initDb();
    }
    return _database;
  }

  Future<Database> initDb() async {
    final _data = await getApplicationDocumentsDirectory();
    final _path = join(_data.path, 'todo.db');
    _database = await openDatabase(
      _path,
      version: 1,
      onCreate: (db, version) async {
        final _sql = '''
        CREATE TABLE todo(
          id INTEGER PRIMARY KEY,
          title TEXT,
          desc TEXT,
          status INTEGER
        )        
        ''';

        return await db.execute(_sql);
      },
    );
    return _database;
  }

  Future<List<Todo>> fetchTodos() async {
    final _db = await database;
    final _response = await _db.query('todo', columns: null);
    return _response.map((e) => Todo.fromMap(e)).toList();
  }

  Future<int> addTodo(Todo todo) async {
    final _db = await database;
    final _response = await _db.insert('todo', todo.toMap());
    return _response;
  }

  Future<int> editTodo(Todo todo) async {
    final _db = await database;
    final _response = await _db.update('todo', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
        where: 'id=?',
        whereArgs: [todo.id]);
    return _response;
  }

  Future<int> deleteTodo(int id) async {
    final _db = await database;
    final _response = await _db.delete('todo', where: 'id=?', whereArgs: [id]);
    return _response;
  }

  Future<void> clear() async {
    final _db = await database;
    await _db.delete('todo');
  }
}
