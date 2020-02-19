import 'dart:core';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'LunchModel.dart';

const String DBNAME = "lunches";

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;

    // lazily instantiate the db the first time it is accessed
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE $DBNAME(id INTEGER PRIMARY KEY, food TEXT, price REAL, rating REAL)");
    });
  }

  //
  //Used to be future in the example

  ///Inserts Lunch object
  void insertLunch(Lunch lunch) async {
    final Database db = await database;

    await db.insert(
      '$DBNAME',
      lunch.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //TODO : Finish method
  /// Insert lunch with two string parameters: lunchName and lunchPrice
  void insertOneLunch(String lunchName, String lunchPrice, String lunchRating) async {
    final Database db = await database;
    await db.rawInsert("INSERT INTO $DBNAME(food, price, rating) VALUES(?, ?, ?)",
        [lunchName, lunchPrice, lunchRating]);
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
        rating: maps[i]['rating'],
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
  Future<void> updateLunch(Lunch lunch, Lunch newLunch) async {
      final Database db = await database;

      //Dirty Checking: Test if any of the field have been modified
      if (newLunch.food != "No name given"){
        lunch.food = newLunch.food;
      }
      if (newLunch.price != 0.0){
        lunch.price = newLunch.price;
      }
      if (newLunch.rating != null){
        lunch.rating = newLunch.rating;
      }

      await db.update(
        '$DBNAME',
        lunch.toMap(),
        where: "id = ?",
        whereArgs: [lunch.id],
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
    db.rawDelete("DELETE FROM $DBNAME");
  }

  List<Lunch> testLunches = [
    Lunch(
      food: "Cardboard Pizza",
      price: 3.00,
      rating: 3,
    ),
    Lunch(
      food: "Cheese Bites sans cheese",
      price: 4.00,
      rating: 2,
    ),
    Lunch(
      food: "Irresistable Orange Chicken",
      price: 5.00,
      rating: 4,
    ),
  ];
}
