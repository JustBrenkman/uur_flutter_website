import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';
import 'package:uur_flutter_website/src/managers/data_manager.dart';

class CompetitionsTable extends StatelessWidget {
  final DataManager _manager;
  const CompetitionsTable(this._manager, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      columns: _manager.competitionDataTableSource.columns,
      source: _manager.competitionDataTableSource,
      header: Text("Competitions"),
    );
  }
}