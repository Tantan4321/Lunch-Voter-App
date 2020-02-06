/// LunchModel.dart
import 'dart:convert';

Lunch clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Lunch.fromJson(jsonData);
}

String clientToJson(Lunch data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Lunch {
  int id;
  String food;
  double price;

  Lunch({var id, var food, var price}){
    this.id = id;
    if(food == null || food.length == 0){
      this.food = "No name given";
    }else{
      this.food = food;
    }
    price = double.tryParse(price.toString());
    if(price != null){
      this.price = price;
    }else{
      this.price = 0.0;
    }
  }



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
