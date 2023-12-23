import 'dart:convert';

import 'package:http/http.dart';
import 'package:request_api/models/response/create_user_response.dart';
import 'package:request_api/models/users.dart';

class Users_Services {
  static const String BASE_URL = 'https://reqres.in/api/';

  static Future<List<Users>> fetchUsers() async {
    final response = await get(Uri.parse(BASE_URL + 'users?page=2'));
    final body = response.body;
    final bodyJson = jsonDecode(body);
    final list =
        List<Users>.from(bodyJson['data'].map((user) => Users.fromJson(user)));
    return list;
  }

  static Future<CreateUserResponse> createUser(String name, String job) async {
    final response = await post(Uri.parse(BASE_URL + 'users'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "job": job}));
    final body = response.body;
    final bodyJson = jsonDecode(body);
    return CreateUserResponse.fromJson(bodyJson);
  }
}
