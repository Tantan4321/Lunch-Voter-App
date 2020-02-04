/// LunchModel.dart
import  'dart:convert';

import 'package:flutter_lunch_voter/Database.dart';
import 'package:sqflite/sqflite.dart';

Lunch clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Lunch.fromJson(jsonData);
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

  factory Lunch.fromJson(Map<String, dynamic> json) => new Lunch(
        id: json["id"],
        food: json["food"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "food": food,
        "price": price,
      };
}
