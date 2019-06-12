import 'dart:html';

import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';

import '../server.dart';

class DataManager with ChangeNotifier {
  Server server = Server();
  static DataManager _instance;

  static DataManager get instance {
    if (_instance == null) {
      _instance = DataManager();
    }
    return _instance;
  }

  void loadResources() async {
    users = await server.getUsers();
    notifyListeners();
    schools = await server.getSchools();
    notifyListeners();
    competitions = await server.getCompetitions();
    notifyListeners();
    teams = await server.getTeams();
    notifyListeners();
    schoolsTeams = await server.getSchoolsTeams();
    notifyListeners();
  }

  void setLocalStorageEntry(String name, String entry) {
    window.localStorage[name] = entry;
    notifyListeners();
  }

  String getLocalStorageEntry(String name) {
    return window.localStorage[name];
  }

  void removeLocalStorageEntry(String name) {
    window.localStorage.remove(name);
  }

  bool isAuthenticated() {
    print(window.localStorage['auth_token']);
    return window.localStorage.containsKey('auth_token');
  }

  List<User> users = [
    User("Jun 1 2019", "1", "Ben", "Brenkman", "JustBrenkman@gmail.com", "BYU", "Director", "admin", "May 7 2019"),
    User("Jun 1 2019", "1", "Kayla", "Cooper", "JustBrenkman@gmail.com", "BYU", "Director", "admin", "May 7 2019"),
    User("Jun 1 2019", "1", "Gabby", "Cooper", "JustBrenkman@gmail.com", "BYU", "Director", "admin", "May 7 2019"),
  ];

  List<School> schools = [
    School("May 3 2019", "1", "Brigham Young university", "BYU", "Campus Dr.", "Provo", "UT", "84604", "4357641732", "BYU"),
    School("May 3 2019", "2", "Brigham Young university", "BYU", "Campus Dr.", "Provo", "UT", "84604", "4357641732", "BYU"),
    School("May 3 2019", "3", "Brigham Young university", "BYU", "Campus Dr.", "Provo", "UT", "84604", "4357641732", "BYU"),
  ];

  List<Team> teams = [
    Team("Jun 1 2019", "Cougars", "BYU-01", "BYU", "Master"),
    Team("Jun 1 2019", "Cougars", "BYU-01", "BYU", "Master"),
    Team("Jun 1 2019", "Cougars", "BYU-01", "BYU", "Master"),
  ];

  List<Team> schoolsTeams = [
    Team("Jun 1 2019", "Cougars", "BYU-01", "BYU", "Master"),
    Team("Jun 1 2019", "Cougars", "BYU-01", "BYU", "Master"),
    Team("Jun 1 2019", "Cougars", "BYU-01", "BYU", "Master"),
  ];

  List<Competition> competitions = [
    Competition('Jun 1 2019', 2, "March madness", "july 1 2019", "july 2 2019", "closed", "closed"),
    Competition('Jun 1 2019', 2, "March madness", "july 1 2019", "july 2 2019", "closed", "closed"),
    Competition('Jun 1 2019', 2, "March madness", "july 1 2019", "july 2 2019", "closed", "closed"),
    Competition('Jun 1 2019', 2, "March madness", "july 1 2019", "july 2 2019", "closed", "closed"),
  ];

  UsersDataTableSource _usersDataTableSource;
  SchoolsDataTableSource _schoolsDataTableSource;
  TeamsDataTableSource _teamsDataTableSource;
  CompetitionDataTableSource _competitionDataTableSource;

  UsersDataTableSource get userDataTableSource {
    if (_usersDataTableSource == null) {
      _usersDataTableSource = UsersDataTableSource(this);
    }
    return _usersDataTableSource;
  }

  SchoolsDataTableSource get schoolsDataTableSource {
    if (_schoolsDataTableSource == null) {
      _schoolsDataTableSource = SchoolsDataTableSource(this);
    }
    return _schoolsDataTableSource;
  }

  TeamsDataTableSource get teamsDataTableSource {
    if (_teamsDataTableSource == null) {
      _teamsDataTableSource = TeamsDataTableSource(this);
    }
    return _teamsDataTableSource;
  }

  CompetitionDataTableSource get competitionDataTableSource {
    if (_competitionDataTableSource == null) {
      _competitionDataTableSource = CompetitionDataTableSource(this);
    }
    return _competitionDataTableSource;
  }
}






class UsersDataTableSource extends DataTableSource {
  final DataManager _manager;

  UsersDataTableSource(this._manager);

  List<DataColumn> get columns {
    return <DataColumn>[
      DataColumn(label: Text("Time Stamp")),
      DataColumn(label: Text("Id")),
      DataColumn(label: Text("First Name")),
      DataColumn(label: Text("Last Name")),
      DataColumn(label: Text("Email")),
      DataColumn(label: Text("School")),
      DataColumn(label: Text("Role")),
      DataColumn(label: Text("Privilege")),
      DataColumn(label: Text("Last Log In")),
    ];
  }

  @override
  DataRow getRow(int index) {
    // TODO: implement getRow
    User user = _manager.users.elementAt(index);
    List<DataCell> cells = [
      DataCell(Text(user.timestamp ?? "")),
      DataCell(Text(user.id ?? "")),
      DataCell(Text(user.firstName ?? "")),
      DataCell(Text(user.lastName ?? "")),
      DataCell(Text(user.email ?? "")),
      DataCell(Text(user.school ?? "")),
      DataCell(Text(user.role ?? "")),
      DataCell(Text(user.privilege ?? "")),
      DataCell(Text(user.lastLogIn ?? "")),
    ];
    DataRow row = DataRow(cells: cells);
    return row;
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _manager.users.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}





class SchoolsDataTableSource extends DataTableSource {
  final DataManager _manager;

  SchoolsDataTableSource(this._manager);

  List<DataColumn> get columns {
    return <DataColumn>[
      DataColumn(label: Text("Time Stamp")),
      DataColumn(label: Text("Id")),
      DataColumn(label: Text("Name")),
      DataColumn(label: Text("abr")),
      DataColumn(label: Text("Address")),
      DataColumn(label: Text("City")),
      DataColumn(label: Text("State")),
      DataColumn(label: Text("Zip Code")),
      DataColumn(label: Text("phone")),
      DataColumn(label: Text("district")),
    ];
  }

  @override
  DataRow getRow(int index) {
    // TODO: implement getRow
    School school = _manager.schools.elementAt(index);
    List<DataCell> cells = [
      DataCell(Text(school.timestamp ?? "")),
      DataCell(Text(school.id ?? "")),
      DataCell(Text(school.name ?? "")),
      DataCell(Text(school.abr ?? "")),
      DataCell(Text(school.address ?? "")),
      DataCell(Text(school.city ?? "")),
      DataCell(Text(school.state ?? "")),
      DataCell(Text(school.zip_code ?? "")),
      DataCell(Text(school.phone ?? "")),
      DataCell(Text(school.district ?? "")),
    ];
    DataRow row = DataRow(cells: cells);
    return row;
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _manager.schools.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}





class TeamsDataTableSource extends DataTableSource {
  final DataManager _manager;

  TeamsDataTableSource(this._manager);

  List<DataColumn> get columns {
    return <DataColumn>[
      DataColumn(label: Text("Time Stamp")),
      DataColumn(label: Text("Name")),
      DataColumn(label: Text("Number")),
      DataColumn(label: Text("School")),
      DataColumn(label: Text("Status")),
      DataColumn(label: Text("View"))
    ];
  }

  @override
  DataRow getRow(int index) {
    // TODO: implement getRow
    Team team = _manager.teams.elementAt(index);
    List<DataCell> cells = [
      DataCell(Text(team.timestamp ?? "")),
      DataCell(Text(team.name ?? "")),
      DataCell(Text(team.number ?? "")),
      DataCell(Text(team.school ?? "")),
      DataCell(Text(team.status ?? "")),
      DataCell(Icon(Icons.remove_red_eye), onTap: () {
        print(team);
      })
    ];
    DataRow row = DataRow(cells: cells);
    return row;
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _manager.teams.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}






class CompetitionDataTableSource extends DataTableSource {
  final DataManager _manager;

  CompetitionDataTableSource(this._manager);

  List<DataColumn> get columns {
    return <DataColumn>[
      DataColumn(label: Text("Time Stamp")),
      DataColumn(label: Text("Id")),
      DataColumn(label: Text("Name")),
      DataColumn(label: Text("Start")),
      DataColumn(label: Text("End")),
      DataColumn(label: Text("Registration Status")),
      DataColumn(label: Text("Status")),
      DataColumn(label: Text("View"))
    ];
  }

  @override
  DataRow getRow(int index) {
    // TODO: implement getRow
    Competition comp = _manager.competitions.elementAt(index);
    List<DataCell> cells = [
      DataCell(Text(comp.timestamp ?? "")),
      DataCell(Text(comp.id.toString() ?? "")),
      DataCell(Text(comp.name ?? "")),
      DataCell(Text(comp.start ?? "")),
      DataCell(Text(comp.end ?? "")),
      DataCell(Text(comp.registration_status ?? "")),
      DataCell(Text(comp.status ?? "")),
      DataCell(Icon(Icons.remove_red_eye), onTap: () {
        print(comp);
      })
    ];
    DataRow row = DataRow(cells: cells);
    return row;
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _manager.competitions.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}





class User {
  final String timestamp;
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String school;
  final String role;
  final String privilege;
  final String lastLogIn;

  User(this.timestamp, this.id, this.firstName, this.lastName, this.email, this.school, this.role, this.privilege, this.lastLogIn);

  User.fromJson(Map<String, dynamic> json) :
        timestamp = json['timestamp'],
        id = json['id'].toString(),
        firstName = json['first_name'],
        lastName = json['last_name'],
        email = json['email'],
        school = json['school'],
        role = json['role'],
        privilege = json['privileges'],
        lastLogIn = json['last_log_in'];

  @override
  String toString() {
    return 'User{timestamp: $timestamp, id: $id, firstName: $firstName, lastName: $lastName, email: $email, school: $school, role: $role, privilege: $privilege, lastLogIn: $lastLogIn}';
  }
}






class School {
  final String timestamp;
  final String id;
  final String name;
  final String abr;
  final String address;
  final String city;
  final String state;
  final String zip_code;
  final String phone;
  final String district;

  School(this.timestamp, this.id, this.name, this.abr, this.address, this.city, this.state, this.zip_code, this.phone, this.district);

  School.fromJson(Map<String, dynamic> json) :
        timestamp = json['timestamp'],
        id = json['id'].toString(),
        name = json['school_name'],
        abr = json['abr'],
        address = json['address'],
        city = json['city'],
        state = json['state'],
        zip_code = json['zipcode'].toString(),
        phone = json['phone'],
        district = json['district'];

  @override
  String toString() {
    return 'School{timestamp: $timestamp, id: $id, name: $name, abr: $abr, address: $address, city: $city, state: $state, zip_code: $zip_code, phone: $phone, district: $district}';
  }
}






class Team {
  final String timestamp;
  final String name;
  final String number;
  final String school;
  final String status;

  Team(this.timestamp, this.name, this.number, this.school, this.status);

  Team.fromJson(Map<String, dynamic> json) :
      timestamp = json['timestamp'],
      name = json['team_name'],
      number = json['team_number'],
      school = json['school_abr'],
      status = json['status'];

  @override
  String toString() {
    return 'Team{timestamp: $timestamp, name: $name, number: $number, school: $school, status: $status}';
  }
}




class Competition {
  final String timestamp;
  final int id;
  final String name;
  final String start;
  final String end;
  final String registration_status;
  final String status;

  Competition(this.timestamp, this.id, this.name, this.start, this.end, this.registration_status, this.status);

  Competition.fromJson(Map<String, dynamic> json) :
        timestamp = json['timestamp'],
        id = json['id'],
        name = json['name'],
        start = json['start'],
        end = json['end'],
        registration_status = json['registration_status'],
        status = json['status'];

  @override
  String toString() {
    return 'Competition{timstamp: $timestamp, id: $id, name: $name, start: $start, end: $end, registration_status: $registration_status, status: $status}';
  }
}