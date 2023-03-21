import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'admin_page.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
              ),
              obscureText: true,
            ),
            SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
              onPressed: () {
                _signIn();
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    try {
      // Sign in user with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Check if user is an admin
      QuerySnapshot adminSnapshot = await _firestore.collection("admins")
          .where("email", isEqualTo: emailController.text)
          .where("password", isEqualTo: passwordController.text)
          .get();

      if (adminSnapshot.size > 0) {
        // User is an admin, navigate to admin dashboard
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboardPage()),
        );
      } else {
        // User is not an admin, show error message
        Fluttertoast.showToast(msg: "You are not an admin!");
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase auth exceptions
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "User not found");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password");
      }
    } catch (e) {
      // Handle other exceptions
      print('Error: $e');
    }
  }


}
