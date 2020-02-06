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
                      hintText: 'Plastic Gyros'),
                  onChanged: (value) {
                    lunchName = value;
                  },
                )
              ),
              Expanded(
                child: TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                      labelText: 'Lunch Price',
                      hintText: '2.00'),
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
                  jsonEncode({"name": lunchName, "price": lunchPrice}));
            },
          ),
        ],
      );
    },
  );
}
