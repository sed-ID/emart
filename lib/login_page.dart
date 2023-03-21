import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'admin_page.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  //method for gesture detector/
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  int _tapCounter = 0;

  //signIn method
  Future<void> signIn() async {
    try {
      if (_emailController.text.trim() == 'admin@gmail.com' && _passwordController.text.trim() == '19101296') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboardPage()),
        );
        return;
      }

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User not found')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Incorrect password')),
        );
      }
    }
  }



  @override
  //dispose controllers for memory management
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //login title
                  Text(
                    "E-Mart",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 50,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome To e-mart.",
                    style: GoogleFonts.alata(
                      fontSize: 18,
                    ),
                  ),
                  //email textfield
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //password textfield
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //"pasword reset button
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ForgotPasswordPage();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.alata(
                              fontSize: 15,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //sign in button
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: signIn,
                      child: Container(
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.red[900],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            "Sign In",
                            style: GoogleFonts.amiko(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //register button
                  SizedBox(
                    height: 15,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Have an account? ",
                        style: GoogleFonts.alata(
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: Text(
                          'Register now',
                          style: GoogleFonts.alata(
                            fontSize: 15,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ... your existing code
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
