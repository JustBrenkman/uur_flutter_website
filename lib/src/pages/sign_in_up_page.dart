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
      backgroundColor: Theme.of(context).canvasColor,
      body: Consumer<StateManager>(
        builder: (BuildContext context, StateManager state, Widget child) {
          return Center(
            child: state.isMobileScreen(context)
                ? _getMobileLoginForm(context)
                : _getDesktopLoginForm(context),
          );
        },
      ),
    );
  }

  Widget _getMobileLoginForm(BuildContext context) {
    return Material(
      child: SizedBox(
        width: 400,
        height: 500,
        child: _getLoginForm(context),
      ),
    );
  }

  Widget _getDesktopLoginForm(BuildContext context) {
    return Card(
      child: SizedBox(width: 400, height: 500, child: _getLoginForm(context)),
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
              child: Text(
                "Sign in",
                style: Theme.of(context).textTheme.headline,
              ),
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
            MediumButton(
              padding: EdgeInsets.only(top: 16, bottom: 8, left: 8, right: 8),
              onPressed: () => _login(context),
              child: _loggInChild(),
            ),
            MediumButton(
              onPressed: () => Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => RegisterPage())),
              child: Text(
                "Register",
              ),
              secondary: true,
            ),
            HyperLink(
              text: 'Forgot password?',
              onTap: () => print('tap'),
            ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    setState(() {
      _isLogginIn = true;
    });
    try {
      var response = await Server.instance
          .login(_emailController.text, _passwordController.text);
      if (response['result'] == 'Success') {
        print(response['auth_token']);
        DataManager.instance
            .setLocalStorageEntry('auth_token', response['auth_token']);
        await Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) =>
                    MyHomePage(title: "Utah Underwater Robotics")));
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(response['message']),
        ));
      }
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    } finally {
      setState(() {
        _isLogginIn = false;
      });
    }
  }

  Widget _loggInChild() {
    return _isLogginIn
        ? CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
          )
        : Text(
            "Log in",
            style: TextStyle(color: Colors.white),
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
  School _selectedSchool;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = new FocusNode();
    _passwordFocusnode = new FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Consumer<StateManager>(
        builder: (BuildContext context, StateManager state, Widget child) {
          return state.isMobileScreen(context)
              ? _getMobileLoginForm(context)
              : _getDesktopLoginForm(context);
        },
      ),
    );
  }

  Widget _getRegisterForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Sign up",
                style: Theme.of(context).textTheme.headline,
              ),
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
              obscureText: true,
            ),
            TextFormFieldUUR(
              labelText: 'Confirm password',
              obscureText: true,
            ),
            SizedBox(
              width: double.infinity,
              child: UURDropDownButton<School>(
                hint: 'Select school',
                value: _selectedSchool,
                onChanged: (School newSchool) {
                  setState(() {
                    _selectedSchool = newSchool;
                  });
                },
                items: DataManager.instance.schools.map<DropdownMenuItem<School>>((School school) {
                  return DropdownMenuItem<School>(
                    value: school,
                    child: Text("  " + school.name),
                  );
                }).toList(),
              ),
            ),
            MediumButton(
              onPressed: () {},
              child: Text("Register",),
            )
          ],
        ),
      ),
    );
  }

  Widget _getMobileLoginForm(BuildContext context) {
    return Material(
      child: SizedBox(
        width: 800,
        height: 800,
        child: ListView(
          children: <Widget>[
            _getRegisterForm(context),
          ],
        ),
      ),
    );
  }

  Widget _getDesktopLoginForm(BuildContext context) {
    return Center(
      child: Card(
        child: SizedBox(
            width: 800,
            height: 800,
            child: ListView(
              children: <Widget>[
                _getRegisterForm(context),
              ],
            )),
      ),
    );
  }
}
