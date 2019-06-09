import 'package:flutter_web/material.dart';
import 'package:uur_flutter_website/font_awesome/font_awesome_flutter.dart';
import 'package:uur_flutter_website/provider/provider.dart';

import 'package:uur_flutter_website/src/managers/state_manager.dart';


class NavigationDrawer extends StatelessWidget {
  final bool open;

  const NavigationDrawer({Key key, this.open = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<StateManager>(
      builder: (BuildContext context, state, Widget child) {
        return _getDrawer(context, state);
      },
    );
  }

  Widget _getDrawer(BuildContext context, StateManager state) {
    Widget child = ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Image.asset("logo/uur_logo.png"),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
        ),
        ListTile(
          selected: state.isCurrentPage(Page.DASHBOARD),
          leading: Icon(FontAwesomeIcons.compass),
          title: Text('Dashboard'),
          onTap: () {
            state.changePage(Page.DASHBOARD);
            if (!open) Navigator.pop(context);
          },
        ),
        ListTile(
          selected: state.isCurrentPage(Page.USERS),
          leading: Icon(FontAwesomeIcons.user),
          title: Text('Users'),
          onTap: () {
            state.changePage(Page.USERS);
            if (!open) Navigator.pop(context);
          },
        ),
        ListTile(
          selected: state.isCurrentPage(Page.SCHOOLS),
          leading: Icon(FontAwesomeIcons.addressBook,),
          title: Text('Schools'),
          onTap: () {
            state.changePage(Page.SCHOOLS);
            if (!open) Navigator.pop(context);
          },
        ),
        ListTile(
          selected: state.isCurrentPage(Page.TEAMS),
          leading: Icon(FontAwesomeIcons.stream),
          title: Text('Teams'),
          onTap: () {
            state.changePage(Page.TEAMS);
            if (!open) Navigator.pop(context);
          },
        ),
        ListTile(
          selected: state.isCurrentPage(Page.COMPETITIONS),
          leading: Icon(FontAwesomeIcons.chartLine),
          title: Text('Competitions'),
          onTap: () {
            state.changePage(Page.COMPETITIONS);
            if (!open) Navigator.pop(context);
          },
        ),
        ListTile(
          selected: state.isCurrentPage(Page.RESOURCES),
          leading: Icon(FontAwesomeIcons.folder),
          title: Text('Resources'),
          onTap: () {
            state.changePage(Page.RESOURCES);
            if (!open) Navigator.pop(context);
          },
        ),
        ListTile(
          selected: state.isCurrentPage(Page.TUTORIALS),
          leading: Icon(FontAwesomeIcons.book),
          title: Text('Tutorials'),
          onTap: () {
            state.changePage(Page.TUTORIALS);
            if (!open) Navigator.pop(context);
          },
        ),
        ListTile(
          selected: state.isCurrentPage(Page.SETTINGS),
          leading: Icon(FontAwesomeIcons.cog),
          title: Text('Settings'),
          onTap: () {
            state.changePage(Page.SETTINGS);
            if (!open) Navigator.pop(context);
          },
        ),
      ],
    );
    return open ? ConstrainedBox(
      constraints: const BoxConstraints.expand(width: 304.0),
      child: Material(
        elevation: 16.0,
        child: child,
      ),
    ) : Drawer(child: child);
  }
}

