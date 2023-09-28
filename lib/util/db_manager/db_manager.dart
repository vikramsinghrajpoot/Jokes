import 'package:news/domain/models/m_joke.dart';
import 'package:news/util/constants/api_urls.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  static Database? db;

  static Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + '/joke.db';
    print("DB Path $path");
    db = await openDatabase(
      path,
      onCreate: (db, ver) {
        return db.execute(
          'CREATE TABLE ${DBAttributes.tableJoke}(${DBAttributes.columnId} INTEGER PRIMARY KEY, ${DBAttributes.columnTitle} TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<MJoke> insert(MJoke todo) async {
    todo.id = await db?.insert(DBAttributes.tableJoke, todo.toMap());
    return todo;
  }

  static Future<List<MJoke?>> getJokes() async {
    List<Map<String, Object?>> maps = await db!.query(DBAttributes.tableJoke,
        columns: [DBAttributes.columnId, DBAttributes.columnTitle], limit: 10);
    if (maps.isEmpty) {
      return [];
    }

    List<MJoke> jokes = List.generate(maps.length, (i) {
      //loop to traverse the list and return student object
      return MJoke(
        id: maps[i]['id'] as int,
        title: maps[i]['title'] as String,
      );
    });
    return jokes;
  }

 static Future<void> deleteJoke(int id) async {
    await db?.delete(
      DBAttributes.tableJoke,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async => db?.close();
}
