import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rivers_demo/pages/login.dart';
import 'package:rivers_demo/services/data_provider.dart';

import 'pages/splash.dart';

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
      home: SplashScreen(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter hooks test")),
      body: ListView(
        children: [
          ListTile(
            trailing: const Icon(Icons.navigate_next),
            title: const Text("Login page"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const LoginPageHookExample(),
                ),
              );
            },
          ),
          ListTile(
            trailing: const Icon(Icons.navigate_next),
            title: const Text("Tab bar page"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const UseTabControllerExample(),
                ),
              );
            },
          ),
          ListTile(
            trailing: const Icon(Icons.navigate_next),
            title: const Text("Api demo with hooks"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const ApiDemoWithHooks(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ApiDemoWithHooks extends ConsumerWidget {
  const ApiDemoWithHooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(userDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api demo with hooks"),
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
