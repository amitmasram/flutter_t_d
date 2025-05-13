import 'package:cv_d_project/core/config/utils/text_string.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the home page after the splash screen
      context.goNamed("home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff9ebb7b), Colors.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                AppTextString.appName,
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),

              const SizedBox(height: 15),
              const Text(
                AppTextString.splashTitle,
                style: TextStyle(fontSize: 21, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
