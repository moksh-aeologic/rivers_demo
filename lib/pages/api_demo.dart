import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/data_provider.dart';

class ApiDemoWithHooks extends ConsumerWidget {
  const ApiDemoWithHooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(userDataProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Api demo with hooks")),
      body: data.when(
          data: (data) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: Text("${data[index].id}"),
                    title: Text("${data[index].title}"),
                    subtitle: Text("${data[index].completed}"),
                  ),
                );
              },
            );
          },
          error: (error, s) => Center(child: Text('$error')),
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}
