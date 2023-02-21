import 'intro_slider.dart';
import 'package:flutter/material.dart';
import 'DashBoard.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {

 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
       color: Colors.white,
       home : Scaffold(
         body: AnimatedSplashScreen(

            backgroundColor: Colors.white,


            pageTransitionType: PageTransitionType.fade,
            splash: 'images/icon.png',
            nextScreen: Crousel()),
       ),
    );


  }
}

