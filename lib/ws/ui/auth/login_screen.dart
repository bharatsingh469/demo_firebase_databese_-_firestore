import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database_01/ws/ui/auth/forgot_password.dart';
import 'package:firebase_database_01/ws/ui/auth/sign-up-screen.dart';
import 'package:firebase_database_01/ws/ui/home_page.dart';
import 'package:firebase_database_01/ws/ui/ui_helper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  loginEmail(String email, String password) async {
    if (email == "" && password == "") {
      UiHelper.CustomAlertBox(context, "Enter required fields");
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        });
      } on FirebaseAuthException catch (exx) {
        return UiHelper.CustomAlertBox(context, exx.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              UiHelper.CustomTextField(
                  emailController, "Enter email", Icons.mail, false),
              UiHelper.CustomTextField(
                  passwordController, "Enter password", Icons.password, false),
              const SizedBox(
                height: 30,
              ),
              UiHelper.CustomButton(() {
                loginEmail(emailController.text.toString(),
                    passwordController.text.toString());
              }, 'Login'),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already Have an Account?",
                    style: TextStyle(fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUpPage()));
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const ForgotPassword()));
                  },
                  child: const Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
