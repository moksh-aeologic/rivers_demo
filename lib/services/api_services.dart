import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:rivers_demo/model/todo_model.dart';

import '../model/user_model.dart';

class ApiServices {
  String endpoint = 'https://10.0.2.2:8000/api/api.json';
  String createUsers = 'http://reqres.in/api/users';

  Future<List<Todods>> getTodas() async {
        final String response = await rootBundle.loadString('api/api.json');
    final List data = await json.decode(response);
      return data.map((e) => Todods.fromJson(e)).toList();

  //   http.Response response = await http.get(Uri.parse(endpoint), headers: {
  //     "Accept": "application/json",
  //     "Access-Control-Allow-Origin": "*"
  //   });
  //   if (response.statusCode == 200) {
  //     final List result = json.decode(response.body);
  //     return result.map((e) => Todods.fromJson(e)).toList();
  //   } else {
  //     throw Exception(response.reasonPhrase);
  //   }
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
