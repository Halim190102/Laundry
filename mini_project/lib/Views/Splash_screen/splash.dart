import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mini_project/Component/Theme/theme.dart';
import 'package:mini_project/Views/Login_screen/login.dart';
import 'package:mini_project/Views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences logindata;

  String email = '';

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(
      () {
        logindata.getString('email');
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initial();
    Timer(
      const Duration(milliseconds: 2500),
      () {
        if (logindata.getString('email') == null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemesColor().splashScreen,
      child: Center(
        child: Image.asset(
          'assets/splash_asset/new.gif',
        ),
      ),
    );
  }
}
