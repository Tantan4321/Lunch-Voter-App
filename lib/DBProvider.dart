import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:core';

import 'LunchModel.dart';

const String DBNAME = "lunches";

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

//TODO: Name of database subject to change
  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = "${documentsDirectory.path}/TestDB.db";
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $DBNAME(id INTEGER PRIMARY KEY, food TEXT, price REAL)");
    });
  }

  //
  //Used to be future in the example
  void insertLunch(Lunch lunch) async {
    final Database db = await database;

    await db.insert(
      '$DBNAME',
      lunch.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

//Retrieve Garbage methods

  ///Retrieve all lunches from the database and return as List
  Future<List<Lunch>> getLunches() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('$DBNAME');

    return List.generate(maps.length, (i) {
      return Lunch(
        id: maps[i]['id'],
        food: maps[i]['food'],
        price: maps[i]['price'],
      );
    });
  }

  /// Retrieve Singular Lunch
  Future<Lunch> getLunch(int id) async {
    final db = await database;
    var res = await db.query("$DBNAME", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Lunch.fromJson(res.first) : Null;
  }

  //Update Garbage Stuff

  ///Updates Lunch Entry
  Future<void> updateLunch(Lunch lunch) async {
    final db = await database;
    await db.update(
      '$DBNAME',
      lunch.toMap(),
      where: "id = ?",
      whereArgs: [lunch.id], //prevents SQL injection - we are anti-vaxx
    );
  }

  ///Delete Lunch
  void deleteLunch(int id) async {
    final db = await database;

    await db.delete(
      '$DBNAME',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  void deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from $DBNAME");
  }

  List<Lunch> testLunches = [
    Lunch(food: "Cardboard Pizza", price: 3.00,),
    Lunch(food: "Cheese Bites sans cheese", price: 4.00,),
    Lunch(food: "Irresistable Orange Chicken", price: 5.00,),
  ];
}
