import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_auth/components/button.dart';
import 'package:login_auth/components/square_tile.dart';
import 'package:login_auth/components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onPressed;
  const RegisterPage({super.key, required this.onPressed});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
//controllers
  final emailController = TextEditingController();
  final passWordController = TextEditingController();
  final confirmPassWordController = TextEditingController();

  // sign user in
  void userSignUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // check if password is confirmed
    if (passWordController.text != confirmPassWordController.text) {
      // close loading circle
      Navigator.pop(context);
      // show error message password don't match
      showErrorMessage("Passwords don't match");
      return;
    }

    // try creating new user with sign up
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passWordController.text,
      );
      // close loading circle if user signed up successfully
      if (mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Close loading dialog before showing error
      if (mounted) Navigator.pop(context);
      // Handle Firebase exceptions
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
                const SizedBox(height: 15),
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 20),

                // create account text
                Text(
                  "Let's create an account for you!",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                ),
                const SizedBox(height: 20),

                //email textfield
                MyTextField(
                  controller: emailController,
                  hintText: "Type email",
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                //password textfield
                MyTextField(
                  controller: passWordController,
                  hintText: "Type password",
                  obscureText: true,
                ),
                const SizedBox(height: 8),

                //confirm password textfield
                MyTextField(
                  controller: confirmPassWordController,
                  hintText: "Confirm password",
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  text: "Sign Up",
                  onTap: userSignUp,
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
                      "Alreay have an account?",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(width: 1),
                    TextButton(
                        onPressed: widget.onPressed,
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
