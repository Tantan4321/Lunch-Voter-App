
import 'package:flutter/material.dart';

import 'Database.dart';
import 'LunchModel.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter SQLite")),
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
          Lunch rnd = testLunches[math.Random().nextInt(testLunches.length)];
          await DBProvider.db.insertLunch(rnd);
          setState(() {});
        },
      ),
    );
  }
}
