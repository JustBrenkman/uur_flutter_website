import 'package:firebase/firestore.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';
import 'package:firebase/firebase.dart';
import 'package:uur_flutter_website/provider/provider.dart';
import 'package:uur_flutter_website/src/managers/state_manager.dart';

class DashBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<StateManager>(
      builder: (BuildContext context, StateManager state, Widget child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: <Widget>[
                  Text("Welcome", style: _getBigTextTheme(context, state),),
                  Text("to the new UUR Website", style: _getLittleTextTheme(context, state),),
                ],
              ),
            ),
            ..._getResponsiveLayout(context, state)
          ],
        );
        },
    );
  }

  List<Widget> _getResponsiveLayout(BuildContext context, StateManager state) {
    if (!state.isMobileScreen(context)) {
      return <Widget>[
        _getDesktopLayout(context)
      ];
    } else {
      return _getMobileLayout(context);
    }
  }

  List<Widget> _getMobileLayout(BuildContext context) {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 64),
        child: _getTodoWidgetList(context),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 64),
        child: _getWhatsNewList(context),
      )
    ];
  }

  Widget _getDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _getTodoWidgetList(context),
          _getWhatsNewList(context)
        ],
      ),
    );
  }

  Widget _getTodoWidgetList(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Things to do:", style: Theme.of(context).textTheme.headline,),
        Padding(
          padding: EdgeInsets.all(16),
          child: Consumer<StateManager>(
            builder: (BuildContext context, StateManager state, Widget child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _listItem(context, "Check out new Tutorials page", onPressed: () => state.changePage(Page.TUTORIALS)),
                  _listItem(context, "Update your Profile", onPressed: () => {}),
                  _listItem(context, "See how well your teams did last year", onPressed: () => {}),
                ],
              );
            },
          ),
        )
      ],
    );
  }

  Widget _getWhatsNewList(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("What's new?", style: Theme.of(context).textTheme.title,),
        Padding(
          padding: EdgeInsets.all(16),
          child: Consumer<StateManager>(
            builder: (BuildContext context, StateManager state, Widget child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _listNewItem(context, "Brand new style", icon: Icon(Icons.star)),
                  _listNewItem(context, "Mobile friendly", icon: Icon(Icons.book)),
                  _listNewItem(context, "Desktop, app and web", icon: Icon(Icons.blur_on)),
                ],
              );
            },
          ),
        )
      ],
    );
  }

  Widget _listItem(BuildContext context, String item, {VoidCallback onPressed}) {
    return InkWell(
      onTap: () => onPressed(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.check, color: Colors.green[500],),
            ),
            Text(item, style: Theme.of(context).textTheme.subhead,),
          ],
        ),
      ),
    );
  }

  Widget _listNewItem(BuildContext context, String item, {Icon icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (icon != null) Padding(padding: const EdgeInsets.only(right: 8.0), child: icon),
          Text(item, style: Theme.of(context).textTheme.subhead,),
        ],
      ),
    );
  }

  _getBigTextTheme(BuildContext context, StateManager state) {
    return state.isMobileScreen(context) ? Theme.of(context).textTheme.display2 : Theme.of(context).textTheme.display4;
  }

  _getLittleTextTheme(BuildContext context, StateManager state) {
    return state.isMobileScreen(context) ? Theme.of(context).textTheme.headline : Theme.of(context).textTheme.display1;
  }
}