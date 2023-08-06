import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_firebase_project/auth.dart';
import 'package:first_firebase_project/home.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:first_firebase_project/login.dart';
import 'package:first_firebase_project/utils.dart';
import 'package:first_firebase_project/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static const String title = 'Setup Firebase';
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
          .copyWith(secondary: Colors.tealAccent)
      ),
      home: MainPage()
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wront!'));
          } else if (snapshot.hasData) {
            // return HomePage();
            return VerifyEmailPage();
          } else {
            return AuthPage();
          }
        }
      ),
    );
  }
}
