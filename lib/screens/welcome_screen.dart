import 'package:gapshap/screens/chat_screen.dart';
import 'package:gapshap/screens/login_screen.dart';
import 'package:gapshap/screens/registration_screen.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>  with TickerProviderStateMixin{

  late AnimationController controller ;
late AnimationController controllheight ;
  late Animation animation ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllheight = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,);

    controllheight.forward();
    controllheight.addListener(() {
      setState(() {});
    });



    controller = AnimationController(
      duration: Duration(seconds: 6),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    controller.forward();





    controller.addListener(() {
      setState(() {});
    });


  }








  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(animation.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: controllheight.value * 100,
                  ),),
          AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                  'BAAT CHEET',
                  textStyle: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,

                  ),
                  colors:  [
                    Colors.blue,
                    Colors.blue,
                    Colors.orangeAccent,
                    Colors.red,
                  ]
              ),
            ],
          ),
  ]
            ),

      Row(
        children: [
          SizedBox(
            width: 90,
          ),
          AnimatedTextKit(
            animatedTexts: [

              TypewriterAnimatedText(
                  'An E - Chatting App',
                  speed: Duration(milliseconds: 400),
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.black45
                  )

              ),
            ],
          ),
        ],
      ),

            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    //Go to login screen.
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                 },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Go to registration screen.
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  RegistrationScreen()));
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),

    )
    );
  }
}
