import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stepy/Colors/app_colors.dart';
import 'package:stepy/Pages/home.dart';
import 'package:stepy/Pages/pageviewpages.dart';

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
    checkOnboardingStatus();
  }

  Future<void> checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isCompleted = prefs.getBool('onboardingComplete') ?? false;
    if (isCompleted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Pageviewpages()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Center(
        child: AnimatedOpacity(
          opacity: OpacityLevel,
          duration: Duration(seconds: 2),
          child: Image.asset('assets/Images/stepyIcon.png'),
        ),
      ),
    );
  }
}
