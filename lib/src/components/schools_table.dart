import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';
import 'package:uur_flutter_website/src/managers/data_manager.dart';

class SchoolsTable extends StatelessWidget {
  final DataManager _manager;
  const SchoolsTable(this._manager, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      columns: _manager.schoolsDataTableSource.columns,
      source: _manager.schoolsDataTableSource,
      header: Text("Schools"),
    );
  }
}