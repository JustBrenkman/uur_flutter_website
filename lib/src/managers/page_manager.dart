import 'package:uur_flutter_website/provider/provider.dart';
import 'package:uur_flutter_website/src/pages/dashboard_page.dart';
import 'package:uur_flutter_website/src/pages/schools_page.dart';
import 'package:uur_flutter_website/src/pages/teams_page.dart';
import 'package:uur_flutter_website/src/pages/users_page.dart';

import 'package:uur_flutter_website/src/managers/state_manager.dart';
import 'package:flutter_web/material.dart';

class PageManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<StateManager>(
      builder: (BuildContext context, StateManager state, Widget child) {
        return _getCurrentPage(state);
      },);
  }

  Widget _getCurrentPage(StateManager state) {
    Widget _page;
    switch (state.currentPage) {
      case Page.DASHBOARD:
        _page = DashBoardPage();
        break;
      case Page.USERS:
        _page = UsersPage();
        break;
      case Page.SCHOOLS:
        _page = SchoolsPage();
        break;
      case Page.TEAMS:
        _page = TeamsPage();
        break;
      case Page.COMPETITIONS:
        _page = Text("Competitions");
        break;
      case Page.TUTORIALS:
        _page = Text("Tutorials");
        break;
      case Page.SETTINGS:
        _page = Text("Settings");
        break;
      case Page.RESOURCES:
        _page = Text("Resources");
        break;
    }

    return _page;
  }
}