
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'DBProvider.dart';
import 'LunchModel.dart';

import 'dart:math';

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
              Lunch rnd = DBProvider.db.testLunches[Random().nextInt(DBProvider.db.testLunches.length)];
              await DBProvider.db.insertLunch(rnd);
              setState(() {});
            }
          ),
            SpeedDialChild(
                child: Icon(Icons.delete),
                label: "Delete All Lunches",
                onTap: () async {
                  await DBProvider.db.deleteAll();
                }
            )
        ]
      ),

    );


  }
}
