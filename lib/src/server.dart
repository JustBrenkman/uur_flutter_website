import 'dart:convert';
import 'package:uur_flutter_website/src/managers/data_manager.dart';
import 'package:http/http.dart' as http;

class Server {
//  String serverURL = "http://localhost:5000/";
  String serverURL = "https://uur.byu.edu/";
  String getUsersURL = "api/users/list";
  String getTeamsURL = "api/users/list";
  String getSchoolsURL = "api/schools/get_school_list";
  String loginURL = 'api/login';

  static Server _instance;

  static Server get instance {
    if (_instance == null)
      _instance = Server();
    return _instance;
  }

  Future<List<User>> getUsers() async {
    final response = await http.get(serverURL + getUsersURL).catchError((error) {
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
    final response = await http.get(serverURL + getTeamsURL).catchError((error) {
      print(error);
    });
//    print(response.body);
    final list =  json.decode(response.body) as List;
//    print("converting to objects");
    List<Team> teamList = [];
    list.forEach((item) => teamList.add(Team.fromJson(item)));
    return teamList;
  }

  Future<List<School>> getSchools() async {
    final response = await http.get(serverURL + getSchoolsURL).catchError((error) {
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
        response = await http.post(serverURL + loginURL, body: json.encode({'email': email, 'password': password, 'remember': true}));
        if (response.statusCode == 500) {
          throw new Exception("Something went wrong with the server");
        }
        return json.decode(response.body);
      } catch (e) {
        print(e);
        throw Exception("Failed to connect to the server");
      }
  }
}

//class ServerInternalError extends HttpException {
//  ServerInternalError(String message) : super(message);
//}