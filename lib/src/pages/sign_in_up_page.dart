import 'package:flutter_web/gestures.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';
import 'package:uur_flutter_website/provider/provider.dart';
import 'package:uur_flutter_website/src/components/uur_ui_components.dart';
import 'package:uur_flutter_website/src/managers/state_manager.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  FocusNode _emailFocusNode, _passwordFocusnode;


  @override
  void initState() {
    super.initState();
    _emailFocusNode = new FocusNode();
    _passwordFocusnode = new FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<StateManager>(
      builder: (BuildContext context, StateManager state, Widget child) {
        return Center(
          child: state.isMobileScreen(context) ? _getMobileLoginForm(context) : _getDesktopLoginForm(context),
        );
      },
    );
  }

  Widget _getMobileLoginForm(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SizedBox(
        width: 400,
        height: 500,
        child: _getLoginForm(context),
      ),
    );
  }

  Widget _getDesktopLoginForm(BuildContext context) {
    return Card(
      child: SizedBox(
          width: 400,
          height: 500,
          child: _getLoginForm(context)
      ),
    );
  }

  Widget _getLoginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Sign in", style: Theme.of(context).textTheme.headline,),
            ),
            SizedBox(
              height: 24,
            ),
            TextFormFieldUUR(
              labelText: "Email",
            ),
            TextFormFieldUUR(
              obscureText: true,
              labelText: "Password",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CheckboxWithLabel(
                onChanged: (bool value) {
                  setState(() {
                    isChecked = value;
                  });
                },
                value: isChecked,
                title: Text("Remember me"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8, left: 8, right: 8),
              child: MaterialButton(
                onPressed: () {},
                height: 45,
                elevation: 2.0,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: SizedBox(width: double.infinity, child: Center(child: Text("Log in", style: TextStyle(color: Colors.white),))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 8, right: 8),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: SizedBox(width: double.infinity, child: Center(child: Text("Register",))),
              ),
            ),
            new RichText(
              text: new TextSpan(
                children: [
                  new TextSpan(
                    text: 'Forgot password?',
                    style: new TextStyle(color: Colors.blue),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  FocusNode _emailFocusNode, _passwordFocusnode;


  @override
  void initState() {
    super.initState();
    _emailFocusNode = new FocusNode();
    _passwordFocusnode = new FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: SizedBox(
        width: 800,
        height: 800,
        child: Card(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Sign up", style: Theme.of(context).textTheme.headline,),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormFieldUUR(
                            labelText: "First Name",
                          ),
                        ),
                        Expanded(
                          child: TextFormFieldUUR(
                            labelText: "last Name",
                          ),
                        ),
                      ],
                    ),
                    TextFormFieldUUR(
                      labelText: "Email",
                    ),
                    TextFormFieldUUR(
                      labelText: 'Password',
                    ),
                    CheckboxListTile(
                      onChanged: (bool value) {
                        setState(() {
                          isChecked = value;
                        });
                      },
                      value: isChecked,
                      title: Text("Remember me"),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8, left: 8, right: 8),
                      child: MaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        height: 45,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                        child: SizedBox(width: double.infinity, child: Center(child: Text("Log in", style: TextStyle(color: Colors.white),))),
                      ),
                    ),
                    new RichText(
                      text: new TextSpan(
                        children: [
                          new TextSpan(
                            text: 'Forgot password?',
                            style: new TextStyle(color: Colors.blue),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {

                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}