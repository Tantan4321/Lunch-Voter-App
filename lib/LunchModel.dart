/// LunchModel.dart
import 'dart:convert';

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
  float price;


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
}