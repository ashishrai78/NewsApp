import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp/view/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 4), (timer){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainScreen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width*1;
    final height = MediaQuery.sizeOf(context).height*1;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              width: width * .9,
                height: height*.7,
                repeat: false,
                'assets/lottie/anim1.json'),
          ),
          Center(
            child: Lottie.asset(
              width: width*.2,
                height: height*.2,
                'assets/lottie/loading.json'),
          ),
        ],
      ),
    );
  }
}
