import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lunch_voter/deletion_dialog.dart';
import 'package:flutter_lunch_voter/lunch_dialog.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';

import 'DBProvider.dart';
import 'LunchModel.dart';

class OtherPage extends StatefulWidget {
  OtherPage({Key key}) : super(key: key);

  @override
  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  @override
  Widget build(BuildContext context) {
    final oCcy = new NumberFormat.simpleCurrency();
    return Scaffold(
      appBar: AppBar(title: Text("School Food Database")),
      body: FutureBuilder<List<Lunch>>(
        future: DBProvider.db.getLunches(),
        builder: (BuildContext context, AsyncSnapshot<List<Lunch>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Lunch item = snapshot.data[index];
                return ListTile(
                  title: Text(item.food),
                    subtitle: Text("Rating: " + item.rating.toString()) ,

                  leading: Icon(Icons.fastfood),
                  trailing: Text(oCcy.format(item.price)),
                  onTap: () async {
                    Lunch newLunch = clientFromJson(await lunchDialog(context));
                    await DBProvider.db.updateLunch(item, newLunch);
                    setState(() {});
                  },
                  onLongPress:() async{
                    await deleteDialog(context, item.id);
                    setState(() {});
                  },
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: SpeedDial(
          closeManually: true,
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: Icon(Icons.add),
                label: "Add a Random Lunch",
                onTap: () async {
                  Lunch rnd = DBProvider.db.testLunches[
                      Random().nextInt(DBProvider.db.testLunches.length)];
                  await DBProvider.db.insertLunch(rnd);
                  setState(() {});
                }),
            SpeedDialChild(
                child: Icon(Icons.delete),
                label: "Delete All Lunches",
                onTap: () async {
                  await DBProvider.db.deleteAll();
                  setState(() {});
                }),
            SpeedDialChild(
                child: Icon(Icons.add_box),
                label: "Insert Own Lunch",
                onTap: () async {
                  DBProvider.db.insertLunch(clientFromJson(await lunchDialog(context)));
                  setState(() {});
                })
          ]),

    );
  }
}
