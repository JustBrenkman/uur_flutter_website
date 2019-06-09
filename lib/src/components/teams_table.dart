import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';
import 'package:uur_flutter_website/src/managers/data_manager.dart';

class TeamsTable extends StatelessWidget {
  final DataManager _manager;
  const TeamsTable(this._manager, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      columns: _manager.teamsDataTableSource.columns,
      source: _manager.teamsDataTableSource,
      header: Text("Teams"),
    );
  }
}