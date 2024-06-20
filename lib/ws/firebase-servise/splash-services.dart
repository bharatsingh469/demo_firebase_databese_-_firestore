import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database_01/ws/ui/auth/login_screen.dart';
import 'package:firebase_database_01/ws/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if(user != null){
      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const HomePage())));

    }else{
      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const LoginPage())));
    }

    
  }
}