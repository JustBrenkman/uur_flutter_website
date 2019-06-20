import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';
import 'package:uur_flutter_website/provider/provider.dart';
import 'package:uur_flutter_website/src/components/teams_table.dart';
import 'package:uur_flutter_website/src/components/uur_ui_components.dart';
import 'package:uur_flutter_website/src/managers/data_manager.dart';
import 'package:uur_flutter_website/src/managers/state_manager.dart';

class TeamsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<DataManager>(
      builder: (BuildContext context, DataManager _manager, Widget child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TeamsTable(_manager),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Card(
                color: Theme.of(context).primaryColor,
                child: InkWell(
                    onTap: () {
                      showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              title: Text('New Team'),
                              children: <Widget>[
                                DisplayBox(
                                  child: Text('Team Number'),
                                ),
                                TextFormFieldUUR(
                                  labelText: 'Name',
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text('Cancel'),
                                      onPressed: () => Navigator.pop(context, false),
                                    ),
                                    FlatButton(
                                      child: Text('Finish', style: TextStyle(color: Theme.of(context).primaryColor),),
                                      onPressed: () => Navigator.pop(context, true),
                                    )
                                  ],
                                ),
                                ButtonGroup(
                                  children: <Widget>[
                                    ToggleButton(
                                      child: Text('Stock'),
                                      buttonAlignment: ToggleButtonAlign.START,
                                    ),
                                    ToggleButton(
                                      child: Text('Open'),
                                      buttonAlignment: ToggleButtonAlign.END,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Icon(Icons.add, color: Colors.grey[100],),
                        )
                    )
                ),
              ),
            ),
            ..._getTeamsList(context, _manager)
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