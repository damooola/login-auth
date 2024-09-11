import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_auth/components/button.dart';
import 'package:login_auth/components/square_tile.dart';
import 'package:login_auth/components/text_field.dart';

class LoginPage extends StatefulWidget {
  final Function()? onPressed;
  const LoginPage({super.key, required this.onPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//controllers
  final emailController = TextEditingController();

  final passWordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();

  // sign user in
  void userSignInWithEmailAndPassword() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          // show loading circle
          child: CircularProgressIndicator(),
        );
      },
    );
    //try signing in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passWordController.text,
      );
      // close loading circle if user signed in
      if (mounted) Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      // Close loading dialog before showing error
      if (mounted) Navigator.of(context).pop();
      // Handle  Firebase exceptions
      showErrorMessage("An error occurred: ${e.message}");
    }
  }

  //error message
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void googleSignIn() async {
    try {
      await _auth.signInWithProvider(_googleAuthProvider);
    } on FirebaseAuthException catch (e) {
      showErrorMessage("${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          // singlechildscrollview to solve overflow error when using onscreen keyboard
          child: SingleChildScrollView(
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
                  hintText: "Type email",
                  obscureText: false,
                ),
                const SizedBox(height: 8),

                //password textfield
                MyTextField(
                  controller: passWordController,
                  hintText: "Type password",
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
                  text: "Sign In",
                  onTap: userSignInWithEmailAndPassword,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                        onTap: googleSignIn,
                        imageAsset: 'lib/images/google.png'),
                    const SizedBox(width: 10),
                    SquareTile(
                      onTap: () {},
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
                        onPressed: widget.onPressed,
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
      ),
    );
  }
}
