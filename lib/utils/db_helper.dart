import 'package:id_scanner/models/card_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();
  factory DBHelper() => _instance;
  DBHelper.internal();
  static Database? _db;

  Future<Database?> createDatabase() async {
    if (_db != null) return _db;

    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'id_scanner.db');
      // await deleteDatabase(path);
      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, v) async {
          //create tables
          await db.execute('CREATE TABLE cards(id VARCHAR(50) PRIMARY KEY,'
              'event VARCHAR(50),'
              'front_image_path VARCHAR(255) NOT NULL,'
              'back_image_path VARCHAR(255) NOT NULL,'
              'user_address VARCHAR(255),'
              'lat REAL,'
              'long REAL,'
              'device_serial_number VARCHAR(50))');
        },
      );
      return _db;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Future<int>> addCard(CardModel card) async {
    Database? db = await createDatabase();
    return db!.insert('cards', card.toMap());
  }

  Future<List> allCards() async {
    Database? db = await createDatabase();
    return db!.query('cards');
  }

  Future<int> deleteCard(String id) async {
    Database? db = await createDatabase();
    return db!.delete('cards', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateCard(CardModel card) async {
    Database? db = await createDatabase();
    return await db!.update('cards', card.toMap(), where: 'id = ?', whereArgs: [card.id]);
  }
}
