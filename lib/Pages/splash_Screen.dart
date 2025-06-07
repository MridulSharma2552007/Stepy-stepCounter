import 'package:flutter/material.dart';
import 'package:stepy/Colors/app_colors.dart';
import 'package:stepy/Pages/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double OpacityLevel = 0.0;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        OpacityLevel = 1.0;
      });
    });
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Center(
        child: AnimatedOpacity(
          opacity: OpacityLevel,
          duration: Duration(seconds: 2),
          child: Image.asset('assets/Images/appicon.png'),
        ),
      ),
    );
  }
}
