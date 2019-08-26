import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';
import 'package:uur_flutter_website/src/components/uur_ui_components.dart';
import 'package:uur_flutter_website/src/managers/data_manager.dart';

class AddTeamDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _name = TextEditingController();
//    TextEditingController _city = TextEditingController();

    // TODO: implement build
    return SimpleDialog(
      title: Text('Add School'),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormFieldUUR(
                controller: _name,
                labelText: "Name",
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              child: Text('CANCEL', style: TextStyle(color: Colors.red),),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text('REGISTER', style: TextStyle(color: Theme
                  .of(context)
                  .primaryColor),),
              onPressed: () async {
//                if (_formKey.currentState.validate()) {
                var doc = await DataManager.instance.registerTeam(
                    Team.selective(
                        name: _name.text,
                    ));
                if (doc != null) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        )
      ],
    );
  }
}