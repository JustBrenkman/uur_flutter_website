import 'dart:html';

import 'package:flutter_web/material.dart';
import 'package:uur_flutter_website/font_awesome/font_awesome_flutter.dart';
import 'package:uur_flutter_website/provider/provider.dart';
import 'package:uur_flutter_website/src/components/navigation_drawer.dart';
import 'package:uur_flutter_website/src/managers/page_manager.dart';
import 'package:uur_flutter_website/src/managers/state_manager.dart';
import 'package:uur_flutter_website/src/managers/data_manager.dart';
import 'package:uur_flutter_website/src/pages/sign_in_up_page.dart';

void main() {
  DataManager _manager = DataManager.instance;
  _manager.loadResources();
  window.document.querySelector("#loading").remove();
//  _manager.removeLocalStorageEntry('auth_token');
  runApp(
      ChangeNotifierProvider<DataManager>(
        child: ChangeNotifierProvider<StateManager>(
          builder: (BuildContext context) => StateManager(),
          child: MyApp(_manager),
        ), builder: (BuildContext context) => _manager,
      )
  );
}

enum Actions {SIGN_OUT, PROFILE, NOTIFICATIONS}

class MyApp extends StatelessWidget {
  DataManager _manager;
  MyApp(this._manager);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (BuildContext context, DataManager value, Widget child) {
        return MaterialApp(
          title: 'Underwater Robotics',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: _manager.getLocalStorageEntry('dark_mode') == 'true' ? Brightness.dark : Brightness.light,
            primaryColor: Colors.indigo,
            accentColor: Colors.pinkAccent,
            primarySwatch: Colors.indigo,
            primaryColorDark: Colors.indigo,
          ),
          home: (_manager.isAuthenticated()) ? MyHomePage(title: 'Utah Underwater Robotics') : LoginPage(),
        );
    },
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Consumer<StateManager>(
      builder: (BuildContext context, StateManager state, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
            actions: _getActions(context, state),
          ),
          drawer: state.isMobileScreen(context) ? _getDrawer() : null,
          body: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              if (!state.isMobileScreen(context)) _getDrawer(open: true),
              Expanded(child: ListView(children: <Widget>[ PageManager()],)),
            ],
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
        },
    );
  }

  List<Widget> _getActions(BuildContext context, StateManager state) {
    List<Widget> exp = <Widget>[
      Consumer<DataManager>(
        builder: (BuildContext context, DataManager _manager, Widget child) {
          return Switch(
            value: _manager.getLocalStorageEntry('dark_mode') == 'true' ?? false,
            onChanged: (bool value) {
              _manager.setLocalStorageEntry('dark_mode', value.toString());
            },
          );
        },
      ),
      IconButton(icon: CircleAvatar(
        backgroundColor: Colors.brown.shade800,
        child: Text('BB'),
      ), onPressed: () {},),
      IconButton(icon: Icon(Icons.notifications), onPressed: () {},),
      IconButton(icon: Icon(FontAwesomeIcons.signOutAlt), onPressed: () {
        DataManager.instance.removeLocalStorageEntry('auth_token');
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      },),
    ];
    List<Widget> single = <Widget>[
//      IconButton(icon: Icon(Icons.more_vert), onPressed: () {},),
      PopupMenuButton<Actions>(
        icon: Icon(Icons.more_vert),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Actions>>[
          const PopupMenuItem(
            value: Actions.PROFILE,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.brown,
                child: Text('BB'),
              ),
              title: Text("Profile"),
            ),
          ),
          PopupMenuItem(
            value: Actions.NOTIFICATIONS,
            child: ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Notifications"),
            ),
          ),
          const PopupMenuItem(
            value: Actions.SIGN_OUT,
            child: ListTile(
              leading: Icon(FontAwesomeIcons.signInAlt),
              title: Text("Signout"),
            ),
          ),
          PopupMenuItem(
            value: Actions.NOTIFICATIONS,
            child: ListTile(
              leading: Consumer<DataManager>(
                builder: (BuildContext context, DataManager _manager, Widget child) {
                  return Switch(
                    value: _manager.getLocalStorageEntry('dark_mode') == 'true' ?? false,
                    onChanged: (bool value) {
                      _manager.setLocalStorageEntry('dark_mode', value.toString());
                    },
                  );
                },
              ),
              title: Text("Dark Mode"),
            ),
          ),
        ],
        onSelected: (action) {
          DataManager.instance.removeLocalStorageEntry('auth_token');
          Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
        },
      )
    ];
    return (state.isMobileScreen(context)) ? single : exp;
  }

  _getDrawer({bool open = false}) {
    return NavigationDrawer(open: open,);
  }
}
