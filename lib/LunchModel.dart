/// LunchModel.dart
import 'dart:convert';
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
  newLunch(Lunch newLunch) async {
    final db = await database;
    var res = await db.insert("Lunch", newLunch.toMap());
    return res;
  }

  getLunch(int id) async {
    final db = await database;
    var res =await  db.query("Client", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Client.fromMap(res.first) : Null ;
  }


}