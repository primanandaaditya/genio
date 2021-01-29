import 'package:manajemen/model/JoinModel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:manajemen/model/UserModel.dart';
import 'package:manajemen/model/StaffModel.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String tabelStaf = 'tabelstaf';
  String colId = "Id";
  String colNik = "Nik";
  String colNama = "Nama";
  String colNamaStaf = "namaStaf";
  String colEmail = "Email";
  String colPassword = "Password";
  String colTelepon = "Telepon";

  String tabelUser = 'tabeluser';
  String colIdStaf = "idStaf";
  String colhakAkses="hakAkses";
  String colstatusAkun = "statusAkun";

  String sqlJoin = "SELECT tabeluser.id, tabeluser.idStaf, tabelstaf.nama as namaStaf, tabeluser.statusAkun, tabelUser.hakAkses FROM tabelstaf INNER JOIN tabeluser ON tabeluser.idstaf = tabelstaf.id";

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }



  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }



  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'DBtes.db';
    var sekolahDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return sekolahDatabase;
  }


  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tabelStaf($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
        ' $colNik TEXT,'
        ' $colNama TEXT,'
        ' $colEmail TEXT,'
        ' $colPassword TEXT,'
        ' $colTelepon TEXT)');

    await db.execute('CREATE TABLE $tabelUser($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
        ' $colIdStaf INTEGER,'
        ' $colhakAkses TEXT,'
        ' $colstatusAkun TEXT)');

  }



// Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getListStaf() async {
    Database db = await this.database;
    var result = await db.query(tabelStaf, orderBy: '$colNama ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getListUser() async {
    Database db = await this.database;
    var result = await db.query(tabelUser, orderBy: '$colId ASC');
    return result;
  }

  Future<List<StaffModel>> staffModels() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tabelStaf);
    return List.generate(maps.length, (i) {
      return StaffModel.withId(
        id: maps[i][colId],
        nik: maps[i][colNik],
        nama: maps[i][colNama],
        email: maps[i][colEmail],
        password: maps[i][colPassword],
        telepon: maps[i][colTelepon]
      );
    });
  }

  Future<List<UserModel>> userModels() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tabelUser);
    return List.generate(maps.length, (i) {
      return UserModel.withID(
          id: maps[i][colId],
          idStaf: maps[i][colIdStaf],
          hakAkses: maps[i][colhakAkses],
          statusAkun: maps[i][colstatusAkun],
      );
    });
  }


  Future<List<JoinModel>> joinModel() async {
    final Database db = await database;

    List<Map<String, dynamic>> maps = await db.rawQuery(sqlJoin);
    return List.generate(maps.length, (i) {
      return JoinModel(
        id: maps[i][colId],
        namaStaf: maps[i][colNamaStaf],
        idStaf: maps[i][colIdStaf],
        hakAkses: maps[i][colhakAkses],
        statusAkun: maps[i][colstatusAkun],
      );
    });
  }

// Insert Operation: Insert a Note object to database
  Future<int> insertStaf(StaffModel m) async {
    Database db = await this.database;
    var result = await db.insert(tabelStaf, m.toMap());
    return result;
  }

  Future<int> insertUser(UserModel m) async {
    Database db = await this.database;
    var result = await db.insert(tabelUser, m.toMap());
    return result;
  }



// Update Operation: Update a Note object and save it to database
  Future<int> updateStaf(StaffModel m) async {
    var db = await this.database;
    var result = await db.update(tabelStaf, m.toMap(), where: '$colId = ?', whereArgs: [m.id]);
    return result;
  }
  Future<int> updateUser(UserModel m) async {
    var db = await this.database;
    var result = await db.update(tabelUser, m.toMap(), where: '$colId = ?', whereArgs: [m.id]);
    return result;
  }


// Delete Operation: Delete a Note object from database
  Future<int> deleteStaf(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $tabelStaf WHERE $colId = $id');
    return result;
  }
  Future<int> deleteUser(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $tabelUser WHERE $colId = $id');
    return result;
  }


// Get number of Note objects in database
  Future<int> getCountStaf() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $tabelStaf');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
  Future<int> getCountUser() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $tabelUser');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

}



