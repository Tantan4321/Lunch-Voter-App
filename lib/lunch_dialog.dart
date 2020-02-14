import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Future<String> lunchDialog(BuildContext context) async {
  String lunchName = '';
  String lunchPrice = '';
  String lunchRating = '';
  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter Lunch'),
        content: Container(
          height: MediaQuery.of(context).size.height / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                  child: TextField(
                autofocus: false,
                decoration: InputDecoration(
                    labelText: 'Lunch Name', hintText: 'e.g. Plastic Gyros'),
                onChanged: (value) {
                  lunchName = value;
                },
              )),
              Expanded(
                  child: TextField(
                keyboardType: TextInputType.number,
                autofocus: false,
                decoration: InputDecoration(
                    labelText: 'Lunch Price', hintText: 'e.g. 2.00'),
                onChanged: (value) {
                  lunchPrice = value;
                },
              )),
              Expanded(
                  //TODO: This is where the epic code goes for the star rating system. EPIC!!!
                  child: RatingBar(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  lunchRating = rating.toString();
                },
              ))
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context,
                  jsonEncode({"food": lunchName, "price": lunchPrice, "rating": lunchRating}));
            },
          ),
        ],
      );
    },
  );
}
