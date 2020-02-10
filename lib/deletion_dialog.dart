import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lunch_voter/DBProvider.dart';
import 'package:sqflite/sqlite_api.dart';

import 'LunchModel.dart';

Future<String> deleteDialog(BuildContext context, int id) async {
  return showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Are you sure you want to delete this lunch?'),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: () {
              DBProvider.db.deleteLunch(id);
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
