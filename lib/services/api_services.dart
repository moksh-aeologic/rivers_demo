import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:rivers_demo/model/todo_model.dart';

import '../model/user_model.dart';

class ApiServices {
  String endpoint = 'http://127.0.0.1:5500/api/api.json';
  String createUsers = 'http://reqres.in/api/users';

  Future<List<Todods>> getTodas() async {
    http.Response response = await http.get(Uri.parse(endpoint), headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    });
    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => Todods.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<UserResponse> createNewUsers() async {
    var body = json.encode({"name": "morpheus", "job": "leader"});
    http.Response response =
        await http.post(Uri.parse(createUsers), body: body);
    if (response.statusCode == 200) {
      final jsonObject = json.decode(response.body);
      var result = UserResponse.fromJson(jsonObject);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final userProvider = Provider<ApiServices>((ref) => ApiServices());
final userString = Provider<String>((ref) => 'Hii there!');
