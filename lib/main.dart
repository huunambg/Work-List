import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/Custom/TodoCard.dart';
import 'package:todo/pages/AddTodo.dart';
import 'package:todo/pages/HomePage.dart';
import 'package:todo/pages/view_data.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('en_US', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Hone(),
    );
  }
}

class Hone extends StatelessWidget {
  const Hone({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/images/demo.json"),
      nextScreen: HomePage(),
      // splashTransition: SplashTransition.rotationTransition,
      duration: 4000,
      splashIconSize: 220, backgroundColor: Colors.black87,
    );
  }
}
