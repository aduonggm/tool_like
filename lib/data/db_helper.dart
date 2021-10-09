import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class IDbHelper {}

class DbHelper implements IDbHelper {
  static final _databaseName = "book_data.db";
  static final _databaseVersion = 1;

  static final tableFile = "file";
  static final columnId = 'id';

  late Database _database;

  Future<void> initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    _database = await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {}
}
