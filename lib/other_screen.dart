import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text("School Food Generator")),
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
                  leading: Text(item.id.toString()),
                  trailing: Text(item.price.toString()),
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
                  Future<String> _asyncInputDialog(BuildContext context) async {
                    String lunchName = '';
                    String lunchPrice = '';
                    return showDialog<String>(
                      context: context,
                      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Enter Lunch'),
                          content: new Row(
                            children: <Widget>[
                              new Expanded(
                                  child: new TextField(
                                    autofocus: true,
                                    decoration: new InputDecoration(labelText: 'Lunch Name', hintText: 'Plastic Gyros'),
                                    onChanged: (value) {
                                      lunchName = value;
                                    },
                                  )
                              ),
                              new Expanded(
                                  child: new TextField(
                                    autofocus: true,
                                    decoration: new InputDecoration(labelText: 'Lunch Price', hintText: 'Plastic Gyros'),
                                    onChanged: (value) {
                                      lunchPrice = value;
                                    },
                                  )
                              )
                            ],
                          ),
                          actions : <Widget>[
                            FlatButton(
                              child: Text('Ok'),
                              onPressed: () async {
                                Navigator.of(context).pop(lunchName);
                                Navigator.of(context).pop(lunchPrice);
                                //TODO: Make new method that takes strings as parameters
                                await DBProvider.db.insertOneLunch(lunchName, lunchPrice);
                                setState(() {});
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                })
          ]),

    );
  }
}
//implement this alert dialog
Future<String> _asyncInputDialog(BuildContext context) async {
  String teamName = '';
  return showDialog<String>(
    context: context,
    barrierDismissible: false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter current team'),
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Team Name', hintText: 'eg. Juventus F.C.'),
                  onChanged: (value) {
                    teamName = value;
                  },
                ))
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop(teamName);
            },
          ),
        ],
      );
    },
  );
}