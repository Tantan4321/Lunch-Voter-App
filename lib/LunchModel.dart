/// LunchModel.dart
import 'dart:convert';

import 'package:flutter_lunch_voter/Database.dart';

Lunch clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Lunch.fromMap(jsonData);
}

String clientToJson(Lunch data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Lunch {
  int id;
  String food;
  double price;

  Lunch({
    this.id,
    this.food,
    this.price,
  });

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
    var res = await db.insert("Lunch", newLunch.toMap());
    return res;
  }

  //Read
  getLunch(int id) async {
    final db = await DBProvider.db.database;
    var res = await db.query("Lunch", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Lunch.fromMap(res.first) : Null;
  }

  //Update
  updateLunch(Lunch newLunch) async {
    final db = await DBProvider.db.database;
    var res = await db.update("Lunch", newLunch.toMap(),
        where: "id = ?", whereArgs: [newLunch.id]);
    return res;
  }

  //Delete
  deleteLunch(int id) async {
    final db = await DBProvider.db.database;
    db.delete("Lunch", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await DBProvider.db.database;
    db.rawDelete("Delete * from Lunch");
  }
}
