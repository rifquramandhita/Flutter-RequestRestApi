import 'dart:convert';

import 'package:http/http.dart';
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
}
