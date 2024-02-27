import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;
late final FirebaseAuthWeb authWeb;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb) {
    app = await Firebase.initializeApp(
      //name: "Instance",
      options: DefaultFirebaseOptions.currentPlatform,
    );
    //await FirebaseAuth.instance.setPersistence(Persistence.NONE);

    auth = FirebaseAuth.instance;
  }
  else {
    app = await Firebase.initializeApp(
      //name: "Instance",
      options: DefaultFirebaseOptions.currentPlatform,
    );

    auth = FirebaseAuth.instance;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<void> Signin() async {
    try {
      print("Oui oui 1");
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "hofferouandi@gmail.com",
          password: "123456789"
      );
      print("Oui oui 2");
      print("Signin - userCredential = $userCredential");
    } on FirebaseAuthException catch (e) {
      print("Exception : $e");
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    print("Oui oui 3");
  }

  Future<void> Signup() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: "hofferouandi@gmail.com",
          password: "123456789"
      );
      print("Signup - userCredential = $userCredential");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: Signin,
            tooltip: 'Signin',
            child: const Icon(Icons.login),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            onPressed: Signup,
            tooltip: 'Signup',
            child: const Icon(Icons.add_circle),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
