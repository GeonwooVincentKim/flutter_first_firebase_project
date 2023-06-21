import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_firebase_project/forgot_password.dart';
import 'package:first_firebase_project/main.dart';
import 'package:first_firebase_project/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginWidget({super.key, required this.onClickedSignUp});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 60),
          FlutterLogo(size: 120),
          SizedBox(height: 20),
          Text(
            "Hey There,\n Welcome back",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)
          ),
          SizedBox(height: 40),
          TextField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "Enter the email")
          ),
          SizedBox(height: 4),
          TextField(
            controller: passwordController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ),
            icon: Icon(Icons.lock_open, size: 32),
            label: Text(
              'Sign In',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: signIn,
          ),
          SizedBox(height: 24),
          GestureDetector(
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20
              ),
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ForgotPasswordPage()
            )),
          ),
          SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.white, fontSize: 20),
              text: 'No Account?  ',
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickedSignUp,
                  text: 'Sign Up',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary
                  )
                )
              ]
            )
          )
        ],
      )
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator())
    );

    // Need to check what is Auth stands for and how to use with it
    // Checkout the details of User Credential meaning and how to apply it into your project

    // https://www.passcamp.com/blog/what-are-login-credentials/#:~:text=A%20login%20credential%20is%20a,password%2C%20or%20simply%20account%20details.
    // https://jins-dev.tistory.com/entry/AWS-%EC%9E%90%EA%B2%A9%EC%A6%9D%EB%AA%85Credential-%EA%B3%BC-IAM%EC%97%90-%EB%8C%80%ED%95%9C-%EA%B8%B0%EB%B3%B8%EC%A0%95%EB%A6%AC
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}