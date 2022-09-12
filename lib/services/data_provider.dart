import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rivers_demo/model/todo_model.dart';
import 'package:rivers_demo/model/user_model.dart';
import 'package:rivers_demo/services/api_services.dart';

final userDataProvider = FutureProvider<List<Todods>>((ref) async {
  return  ref.watch(userProvider).getTodas();
});

final createUserProvider = FutureProvider<UserResponse>((ref) async {
  return  ref.watch(userProvider).createNewUsers();
});
