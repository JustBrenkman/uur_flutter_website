import 'package:firebase/firestore.dart';
import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart';
import 'package:uur_flutter_website/provider/provider.dart';
import 'package:uur_flutter_website/src/components/schools_table.dart';
import 'package:uur_flutter_website/src/managers/data_manager.dart';

class SchoolsPage extends StatelessWidget {
  fs.Firestore store = firestore();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream: firestore().collection('schools').onSnapshot,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) return Center(child: Text('Loading...', style: Theme.of(context).textTheme.display2,));
        QuerySnapshot snap = snapshot.data;
        print(snap.docs.length);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              color: Theme.of(context).primaryColor,
              child: InkWell(
                onTap: () {},
                child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Icon(Icons.add, color: Colors.grey[100],),
                    )
                ),
              ),
            ),
            ...snap.docs.map((doc) {
              return Card(
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(doc.data()['name'], style: Theme.of(context).textTheme.title,),
                            Text(doc.data()['active'] ?? false ? "ACTIVE" : "INACTIVE", style: TextStyle(color: doc.data()['active'] ?? false ? Colors.green : Colors.red))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("${doc.data()['address']}, ${doc.data()['state']}, ${doc.data()['zipcode']} \t\t ${doc.data()['phone']}"),
                              Text("${doc.data()['district']}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList()
          ],
        );
      },
    );
  }
}