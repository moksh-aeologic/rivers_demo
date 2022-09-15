import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rivers_demo/pages/login.dart';
import 'package:rivers_demo/services/data_provider.dart';

import 'pages/api_demo.dart';
import 'pages/scroll_demo.dart';
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
      home: const SplashScreen(),
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
          ListTile(
            trailing: const Icon(Icons.navigate_next),
            title: const Text("Scroll demo with hooks"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const ScrollDemo(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
