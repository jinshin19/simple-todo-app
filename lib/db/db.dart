import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  Database? db;
  final tblN = "todos";
  Future<Database> get database async {
    if (db != null) return db!;
    db = await init();
    return db!;
  }

  Future<String> get fullPath async {
    const name = "dbservice.db";
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> init() async {
    final path = await fullPath;
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''CREATE TABLE IF NOT EXISTS $tblN(
            id INTEGER PRIMARY KEY,
            value TEXT,
            completed INTEGER
          )''');
      },
    );
  }

  addTodo(String val) async {
    final dbInstance = await database;
    dbInstance.insert(
      tblN,
      {'value': val, 'completed': 0},
    );
    return "ok";
  }

  Future<List<Map<String, dynamic>>> getTodos() async {
    final dbInstance = await database;
    final data = await dbInstance.query(tblN);
    if (data.isNotEmpty) {
      return data;
    } else {
      return [];
    }
  }

  completedTodo(id, completed) async {
    final dbInstance = await database;
    dbInstance.update(
      tblN,
      {'completed': completed},
      where: 'id = ?',
      whereArgs: [id],
    );
    return "ok";
  }

  deleteTodo(id) async {
    final dbInstance = await database;
    dbInstance.delete(tblN, where: 'id = ?', whereArgs: [id]);
    return "ok";
  }
}
