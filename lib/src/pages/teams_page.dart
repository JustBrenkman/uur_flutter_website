import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';
import 'package:uur_flutter_website/provider/provider.dart';
import 'package:uur_flutter_website/src/components/uur_ui_components.dart';
import 'package:uur_flutter_website/src/dialogs/add_school.dart';
import 'package:uur_flutter_website/src/dialogs/add_team.dart';
import 'package:uur_flutter_website/src/managers/data_manager.dart';
import 'package:uur_flutter_website/src/managers/state_manager.dart';

class TeamsPage extends StatefulWidget {
  @override
  _TeamsPageState createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  Map<String, String> schoolNames = {};

  void getSchoolInfo(String id, DocumentReference ref) async {
    var snap = await ref.get();
    setState(() {
      schoolNames[id] = snap.get('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore().collection('teams').onSnapshot,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) return Center(child: Text('Loading...', style: Theme.of(context).textTheme.display2,));
        QuerySnapshot snap = snapshot.data;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              color: Theme.of(context).primaryColor,
              child: InkWell(
                onTap: () => showDialog(context: context, builder: (context) => AddTeamDialog()),
                child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Icon(Icons.add, color: Colors.grey[100],),
                    )
                ),
              ),
            ),
            ...snap.docs.map((doc) {
              getSchoolInfo(doc.id, doc.data()['school']);
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
                            Text('${schoolNames[doc.id] ?? ''}')
//                            Text(doc.data()['active'] ?? false ? "ACTIVE" : "INACTIVE", style: TextStyle(color: doc.data()['active'] ?? false ? Colors.green : Colors.red))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
//                              Text("${doc.data()['address']}, ${doc.data()['state']}, ${doc.data()['zipcode']} \t\t ${doc.data()['phone']}"),
//                              Text("${doc.data()['district']}"),
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

  List<Widget> _getTeamsList(BuildContext context, DataManager _manager) {
    return _manager.schoolsTeams.map((team) => TeamCard(team: team, onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => SingleTeamPage(team: team,))),)).toList();
  }
}

class SingleTeamPage extends StatelessWidget {
  final Team team;

  const SingleTeamPage({Key key, @required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(team.number),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.edit), onPressed: () {},)
        ],
      ),
      body: Consumer<StateManager>(
        builder: (BuildContext context, StateManager _state, Widget child) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  children: <Widget>[
                  Text(team.name, style: _getStyle(context, _state),)
              ]
              ),
            ),
          );
        },
      ),
    );
  }

  TextStyle _getStyle(BuildContext context, StateManager _state) {
    return _state.isMobileScreen(context) ? Theme.of(context).textTheme.display3 : Theme.of(context).textTheme.display4;
  }
}