import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';
import 'package:uur_flutter_website/provider/provider.dart';
import 'package:uur_flutter_website/src/components/teams_table.dart';
import 'package:uur_flutter_website/src/managers/data_manager.dart';

class TeamsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Consumer<DataManager>(
          builder: (BuildContext context, DataManager _manager, Widget child) {
            return Row(
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
            );
          },
        ),
      ],
    );
  }
}