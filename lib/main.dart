import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Setup Firebase';
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainPage()
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<void> initFirebaseMessaging() async {
    print(await FirebaseMessaging.instance.getInitialMessage());
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print("????");
        print(message.notification!.title);
      } else {
        print("null~!!");
      }
    });

    print("Test!");
  }

  @override
  void initState() {
    super.initState();
    print(FirebaseMessaging.instance.pluginConstants);
    print("Check -> ${FirebaseMessaging.instance.isSupported()}");
    initFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Hi"),
      ),
    );
  }
}