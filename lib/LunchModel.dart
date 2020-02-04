/// LunchModel.dart
import  'dart:convert';

import 'package:flutter_lunch_voter/Database.dart';
import 'package:sqflite/sqflite.dart';

Lunch clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Lunch.fromMap(jsonData);
}

String clientToJson(Lunch data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Lunch {
  final int id;
  final String food;
  final double price;

  Lunch({
    this.id,
    this.food,
    this.price,
  });

  final Future<Database> database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
      join(await getDatabasesPath(), 'lunch_database.db'),
  );



  factory Lunch.fromMap(Map<String, dynamic> json) => new Lunch(
        id: json["id"],
        food: json["food"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "food": food,
        "price": price,
      };

  //CRUD Operations

  //Create
  newLunch(Lunch newLunch) async {
    final db = await DBProvider.db.database;
    var res = await db.insert("lunch", newLunch.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,);

    return res;
  }


  //Read
  getLunch(int id) async {
    final db = await DBProvider.db.database;
    var res = await db.query("lunch", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Lunch.fromMap(res.first) : Null;
  }

  //Update
  updateLunch(Lunch newLunch) async {
    final db = await DBProvider.db.database;
    var res = await db.update("lunch", newLunch.toMap(),
        where: "id = ?", whereArgs: [newLunch.id]);
    return res;
  }

  //Delete
  deleteLunch(int id) async {
    final db = await DBProvider.db.database;
    db.delete("lunch", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await DBProvider.db.database;
    db.rawDelete("Delete * from lunch");
  }
}
