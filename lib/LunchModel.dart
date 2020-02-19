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
  double rating;

  Lunch({var id, var food, var price, var rating}){
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
    rating = double.tryParse(rating.toString());
    if(rating != null){
      this.rating = rating;
    }else{
      this.rating = 0.0;
    }
  }



  factory Lunch.fromJson(Map<String, dynamic> json) => new Lunch(
        id: json["id"],
        food: json["food"],
        price: json["price"],
        rating: json["rating"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "food": food,
        "price": price,
        "rating": rating,
      };
}
