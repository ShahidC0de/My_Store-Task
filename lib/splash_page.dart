import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task/core/theme/pallete.dart';
import 'package:task/features/home/presentation/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context, Home2.route(), (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        SizedBox(
            width: width,
            height: height,
            child: Image.asset(
              'assets/splash_screen/Pasted image.png',
              fit: BoxFit.contain,
            )),
        Positioned(
            top: height * 0.10,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'My Store',
                style: Pallete.titleText.copyWith(fontSize: 35),
              ),
            )),
        Positioned(
            top: height * 0.70,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Valkammen',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            )),
        Positioned(
            top: height * 0.75,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: height / 3,
                width: width / 1.5,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'la kare kufd dfhii dkjfd ieiru kadfkdf  dfdjfhdjfh djfhdjfhdjfh djfhdjfhdjfh jdfhdjfhdj jdfhdjfhdj kdfjkdfjdkfj akdfjdkfjdkfa dkfhajjdaf dfdjfh akdfdk kdfa ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ))
      ]),
    );
  }
}
