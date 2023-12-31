import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home")
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Signed In as',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              user.email!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50)
              ),
              icon: const Icon(Icons.arrow_back, size: 32),
              label: Text(
                'Sign Out',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () => FirebaseAuth.instance.signOut(),
            )
          ],
        )
      ),
    );
  }
}
