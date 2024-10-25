import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = new Timer(Duration(seconds: 1, milliseconds: 500), () {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? currentUser = auth.currentUser;
      if (currentUser == null) {
        Navigator.of(context).pushNamedAndRemoveUntil('/decisao', (_) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil('/main', (_) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xffF8CCCC), // Define a cor de fundo usando o valor hexadecimal
      body: Center(
        child: Image.asset(
          'assets/images/logopet.png',
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
