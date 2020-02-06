import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String> lunchDialog(BuildContext context) async {
  String lunchName = '';
  String lunchPrice = '';
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
                      labelText: 'Lunch Name',
                      hintText: 'e.g. Plastic Gyros'),
                  onChanged: (value) {
                    lunchName = value;
                  },
                )
              ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  decoration: InputDecoration(
                      labelText: 'Lunch Price',
                      hintText: 'e.g. 2.00'),
                  onChanged: (value) {
                    lunchPrice = value;
                  },
                )
              )
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context,
                  jsonEncode({"food": lunchName, "price": lunchPrice}));
            },
          ),
        ],
      );
    },
  );
}
