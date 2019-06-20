import 'dart:convert';
import 'package:uur_flutter_website/src/managers/data_manager.dart';
import 'package:http/http.dart' as http;

class Server {
//  String _serverURL = "http://localhost:5000/";
  String _serverURL = "https://uur.byu.edu/";
  String _getUsersURL = "api/users/list";
  String _getTeamsURL = "api/team/get_team_list";
  String _getSchoolsTeamsURL = "api/team/get_team_list_from_school";
  String _getSchoolsURL = "api/schools/get_school_list";
  String _loginURL = 'api/login';
  String _competitionsURL = 'api/competition/get_full_list';

  static Server _instance;

  static Server get instance {
    if (_instance == null) {
      _instance = Server();
    }
    return _instance;
  }

  Future<List<User>> getUsers() async {
    final response = await http.get(_serverURL + _getUsersURL).catchError((error) {
      print(error);
    });
//    print(response.body);
    final list =  json.decode(response.body) as List;
//    print("converting to objects");
    List<User> userList = [];
    list.forEach((item) => userList.add(User.fromJson(item)));
    return userList;
  }

  Future<List<Team>> getTeams() async {
    final response = await http.post(_serverURL + _getTeamsURL, body: {'auth_token': DataManager.instance.getLocalStorageEntry('auth_token')}).catchError((error) {
      print(error);
    });
    print(response.body);
    final list =  json.decode(response.body) as List;
    List<Team> teamList = [];
    list.forEach((item) => teamList.add(Team.fromJson(item)));
    return teamList;
  }

  Future<List<Team>> getSchoolsTeams() async {
    final response = await http.post(_serverURL + _getSchoolsTeamsURL, body: json.encode({'auth_token': DataManager.instance.getLocalStorageEntry('auth_token')})).catchError((error) {
      print(error);
    });
    print(response.body);
    final list =  json.decode(response.body) as List;
    List<Team> teamList = [];
    list.forEach((item) => teamList.add(Team.fromJson(item)));
    return teamList;
  }

  Future<List<School>> getSchools() async {
    final response = await http.get(_serverURL + _getSchoolsURL).catchError((error) {
      print(error);
    });
//    print(response.body);
    final list =  json.decode(response.body) as List;
//    print("converting to objects");
    List<School> schoolList = [];
    list.forEach((item) => schoolList.add(School.fromJson(item)));
    return schoolList;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    http.Response response;
      try {
        response = await http.post(_serverURL + _loginURL, body: json.encode({'email': email, 'password': password, 'remember': true}));
        if (response.statusCode == 500) {
          throw new Exception("Something went wrong with the server");
        }
        return json.decode(response.body);
      } catch (e) {
        print(e);
        throw Exception("Failed to connect to the server");
      }
  }

  Future<List<Competition>> getCompetitions() async {
    final response = await http.post(_serverURL + _competitionsURL, body: json.encode({'auth_token': DataManager.instance.getLocalStorageEntry('auth_token')}));
    final list = json.decode(response.body) as List;
    List<Competition> compList = [];
    list.forEach((item) => compList.add(Competition.fromJson(item)));
    return compList;
  }
}


//class ServerInternalError extends HttpException {
//  ServerInternalError(String message) : super(message);
//}