import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:login_auth/components/button.dart';
import 'package:login_auth/components/square_tile.dart';
import 'package:login_auth/components/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//controllers
  final emailController = TextEditingController();

  final passWordController = TextEditingController();
  final logger = Logger();

  // sign user in
  void userSignIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try signing in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passWordController.text);

      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        logger.e("no user found for that email");
      } else if (e.code == "wrong-password") {
        logger.e("wrong password, try again!");
      }
    }
  }

//register now button
  void registerNow() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              // logo
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(height: 30),

              // welcome text
              Text(
                "welcome back, you've been missed!",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
              ),
              const SizedBox(height: 25),

              //email textfield
              MyTextField(
                controller: emailController,
                hintText: "Type your email",
                obscureText: false,
              ),
              const SizedBox(height: 8),

              //password textfield
              MyTextField(
                controller: passWordController,
                hintText: "Type your password",
                obscureText: true,
              ),
              //forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  //wrap widgets in a row and set MainAxisAlignment to end to push to the right
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey.shade500),
                      // textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: userSignIn,
              ),

              const SizedBox(height: 20),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade600,
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade600,
                    ))
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // google and apple sign buttons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(imageAsset: 'lib/images/google.png'),
                  SizedBox(width: 10),
                  SquareTile(
                    imageAsset: 'lib/images/apple.png',
                  )
                ],
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(width: 1),
                  TextButton(
                      onPressed: registerNow,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
