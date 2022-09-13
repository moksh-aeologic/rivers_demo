import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePageHookExample extends HookWidget {
  const HomePageHookExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailcontroller = useTextEditingController();
    final passwordcontroller = useTextEditingController();
    useEffect(() {
      debugPrint('On initstate');
      return () {
        debugPrint('On dispose');
      };
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailcontroller,
          ),
          TextFormField(
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
  final future =   useMemoized(()=>NetworkAssetBundle(Uri.parse('url'))
      .load(url)
      .then((value) => value.buffer.asUint8List())
      .then((data) => Image.memory(data)));
      final snapshot = useFuture(future);
      // var image = ;
    debugPrint('Rebuild');
    final tabController = useTabController(initialLength: 3);
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
          ],
        ),
      ),
      body: TabBarView(controller: tabController, children: [
        Center(
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
        ),
        Center(child: snapshot.hasData ? snapshot.data : null),
        Container(),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await
        },
      ),
    );
  }
}
