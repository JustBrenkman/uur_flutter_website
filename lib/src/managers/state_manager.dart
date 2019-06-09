import 'package:flutter_web/widgets.dart';

enum Page {DASHBOARD, USERS, SCHOOLS, TEAMS, COMPETITIONS, RESOURCES, TUTORIALS, SETTINGS}

class StateManager with ChangeNotifier {
  Page _currentPage = Page.DASHBOARD;

  bool isCurrentPage(Page page) {
    return _currentPage == page;
  }

  Page get currentPage => _currentPage;

  void changePage(Page page) {
    _currentPage = page;
    notifyListeners();
  }

  bool isMobileScreen(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width < size.height;
  }
}