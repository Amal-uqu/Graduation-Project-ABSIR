import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;

  DatabaseHelper._instance();

  String colId = 'id';
  String colEmail = 'email';
  String colName = 'name';
  String colPassword = 'password';
  String userTabel = 'userTable';



  Future<Database?> get db async {
    _db ??= await _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'Absir.db';

    final Database db =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  void _createDb(Database db, int version) async {


    await db.execute('''CREATE TABLE $userTabel(
      $colId INTEGER PRIMARY KEY AUTOINCREMENT,
      $colName TEXT,
      $colEmail TEXT,
      $colPassword TEXT
      )''');
  }
}
