import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';
import 'package:uur_flutter_website/src/components/uur_ui_components.dart';
import 'package:uur_flutter_website/src/managers/data_manager.dart';

class AddSchoolDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _name = TextEditingController();
    TextEditingController _district = TextEditingController();
    TextEditingController _phone = TextEditingController();
    TextEditingController _abbreviation = TextEditingController();
    TextEditingController _address = TextEditingController();
    TextEditingController _city = TextEditingController();
    TextEditingController _state = TextEditingController();
    TextEditingController _zipecode = TextEditingController();
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
//                validator: (text) => text.toString().isNotEmpty,
              ),
              TextFormFieldUUR(
                controller: _district,
                labelText: "District",
              ),
              TextFormFieldUUR(
                controller: _phone,
                labelText: "Phone",
              ),
              TextFormFieldUUR(
                controller: _abbreviation,
                labelText: "Abbreviation",
              ),
              TextFormFieldUUR(
                controller: _address,
                labelText: "Address",
              ),
              TextFormFieldUUR(
                controller: _city,
                labelText: "City",
              ),
              TextFormFieldUUR(
                controller: _state,
                labelText: "State",
              ),
              TextFormFieldUUR(
                controller: _zipecode,
                labelText: "Zipcode",
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
              child: Text('REGISTER', style: TextStyle(color: Theme.of(context).primaryColor),),
              onPressed: () async {
//                if (_formKey.currentState.validate()) {
                  var doc = await DataManager.instance.registerSchool(School.selective(
                    name: _name.text,
                    district: _district.text,
                    phone: _phone.text,
                    abr: _abbreviation.text,
                    address: _address.text,
                    city: _city.text,
                    state: _state.text,
                    zip_code: _zipecode.text,
                    active: true
                  ));

                  if (doc != null) {
                    Navigator.pop(context);
                  }
//                }
              },
            ),
          ],
        )
      ],
    );
  }
}