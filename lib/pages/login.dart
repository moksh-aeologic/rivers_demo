import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPageHookExample extends HookWidget {
  const LoginPageHookExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailcontroller = useTextEditingController();
    var passwordcontroller = useTextEditingController();
    useEffect(() {
      debugPrint('On initstate');
      return () {
        debugPrint('On dispose');
      };
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login with hook"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: const InputDecoration(hintText: "Email"),
            controller: emailcontroller,
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: "Password"),
            controller: passwordcontroller,
          ),
          ElevatedButton(
              onPressed: () {
                final user = emailcontroller.text;
                final pass = passwordcontroller.text;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Login in with $user $pass")));
              },
              child: const Text('Login'))
        ],
      ),
    );
  }
}

String url = "https://bit.ly/3qwBNUF";

class UseTabControllerExample extends HookWidget {
  const UseTabControllerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countDown = useMemoized(() => CountDown(from: 60));
    final notifier = useListenable(countDown);
    final future = useMemoized(() => NetworkAssetBundle(Uri.parse('url'))
        .load(url)
        .then((value) => value.buffer.asUint8List())
        .then((data) => Image.memory(data)));
    final snapshot = useFuture(future);
    // var image = ;
    debugPrint('Rebuild');
    final tabController = useTabController(initialLength: 4);
    useEffect(() {
      tabController.addListener(() {
        debugPrint("tab index:${tabController.index}");
      });
      return null;
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hook example with tab"),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(icon: Icon(Icons.train)),
            Tab(icon: Icon(Icons.flight)),
            Tab(icon: Icon(Icons.bus_alert)),
            Tab(icon: Icon(Icons.bus_alert)),
          ],
        ),
      ),
      body: TabBarView(controller: tabController, children: [
        const Tab1(),
        Tab2(snapshot: snapshot),
        const Tab3(),
        // const Tab1(),
        // Tab2(snapshot: snapshot),
        Tab4(notifier: notifier),
      ]),
    );
  }
}

final provider = StateProvider((ref) {
  return 0;
});

class Tab3 extends HookWidget {
  const Tab3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final state = useState(0);
// final count = ref.
    // useState<provider>().value;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('You have pressed this many time'),
            Text("${state.value}"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          state.value++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Tab4 extends StatelessWidget {
  const Tab4({Key? key, required this.notifier}) : super(key: key);

  final CountDown notifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(notifier.value.toString()),
      ),
    );
  }
}

class Tab2 extends StatelessWidget {
  const Tab2({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  final AsyncSnapshot<Image> snapshot;

  @override
  Widget build(BuildContext context) {
    return Center(child: snapshot.hasData ? snapshot.data : null);
  }
}

class Tab1 extends StatelessWidget {
  const Tab1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: HookBuilder(
        builder: (_) {
          final toggle = useState(true);
          return Checkbox(
              value: toggle.value,
              onChanged: (_) {
                toggle.value = !toggle.value;
              });
        },
      ),
    );
  }
}

class CountDown extends ValueNotifier<int> {
  late StreamSubscription sub;
  CountDown({required int from}) : super(from) {
    sub = Stream.periodic(
      const Duration(seconds: 1),
      (v) => from - v,
    ).takeWhile((value) => value >= 0).listen((event) {
      value = event;
    });
  }
  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}
