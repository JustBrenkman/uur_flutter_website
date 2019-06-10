import 'package:flutter_web/gestures.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';
import 'package:uur_flutter_website/provider/provider.dart';
import 'package:uur_flutter_website/src/components/uur_ui_components.dart';
import 'package:uur_flutter_website/src/managers/data_manager.dart';
import 'package:uur_flutter_website/src/managers/state_manager.dart';

import '../../main.dart';
import '../server.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  FocusNode _emailFocusNode, _passwordFocusnode;
  TextEditingController _emailController, _passwordController;
  bool _isLogginIn = false;


  @override
  void initState() {
    super.initState();
    _emailFocusNode = new FocusNode();
    _passwordFocusnode = new FocusNode();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Consumer<StateManager>(
        builder: (BuildContext context, StateManager state, Widget child) {
          return Center(
            child: state.isMobileScreen(context) ? _getMobileLoginForm(context) : _getDesktopLoginForm(context),
          );
        },
      ),
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
              controller: _emailController,
              labelText: "Email",
            ),
            TextFormFieldUUR(
              controller: _passwordController,
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
                onPressed: () async {
                  setState(() {
                    _isLogginIn = true;
                  });
                  try {
                    var response = await Server.instance.login(_emailController.text, _passwordController.text);
                    if (response['result'] == 'Success') {
                      print(response['auth_token']);
                      DataManager.instance.setLocalStorageEntry('auth_token', response['auth_token']);
                      await Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context) => MyHomePage(title: "Utah Underwater Robotics")));
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text(response['message']),));
                    }
                  } catch (e) {
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.toString()),));
                  } finally {
                    setState(() {
                      _isLogginIn = false;
                    });
                  }
                },
                height: 45,
                elevation: 1.0,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: SizedBox(width: double.infinity, child: Center(
                    child: _isLogginIn ? CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                    ) : Text("Log in", style: TextStyle(color: Colors.white),)
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 8, right: 8),
              child: RaisedButton(
                elevation: 1,
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
                        elevation: 1.0,
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