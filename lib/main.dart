import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rivers_demo/pages/home.dart';
import 'package:rivers_demo/services/data_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(userDataProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>  UseTabControllerExample
                        // HomePageHookExample
                        ()));
              },
              icon: const Icon(Icons.navigate_next_rounded))
        ],
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () async {
      //   var res = await ref.read(createUserProvider);
      //   res.whenData((value) {
      //     if (value.data != null) {
      //       print(value.toJson());
      //     } else {
      //       print('Something went wrong!');
      //     }
      //   });
      // }),
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
