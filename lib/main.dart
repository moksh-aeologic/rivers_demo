import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rivers_demo/pages/login.dart';

import 'pages/api_demo.dart';
import 'pages/image_rotate_effect_demo.dart';
import 'pages/rotate_image_demo.dart';
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
          myListTile(
              context, "Login demo with hooks", const LoginPageHookExample()),
          myListTile(context, "Tab bar demo with hooks",
              const UseTabControllerExample()),
          myListTile(context, "Api demo with hooks", const ApiDemoWithHooks()),
          myListTile(context, "Scroll demo with hooks", const ScrollDemo()),
          myListTile(context, "Animation demo with hooks", const ImageRotateDemo()),
          myListTile(context, "Animation rotate demo with hooks", const ImageRotateEffectDemo()),
        ],
      ),
    );
  }

  myListTile(BuildContext context, String title, page) {
    return ListTile(
      trailing: const Icon(Icons.navigate_next),
      title: Text(title),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute<void>(builder: (context) => page));
      },
    );
  }
}
