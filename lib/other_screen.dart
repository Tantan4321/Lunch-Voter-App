
import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text("Flutter SQLite Test")),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Lunch rnd = DBProvider.db.testLunches[Random().nextInt(DBProvider.db.testLunches.length)];
          await DBProvider.db.insertLunch(rnd);
          setState(() {});
        },
      ),
    );


  }
}
