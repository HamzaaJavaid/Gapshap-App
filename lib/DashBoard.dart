import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:gapshap/Login.dart';
import 'package:gapshap/forgot%20password.dart';
import 'RegistrationScreen.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin{

  late AnimationController controllOpacity ;
  late AnimationController controllHeight ;
  late Animation animation;
Color color = Colors.white;
  @override
  void initState() {
    // TODO: implement initState


    controllHeight = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,);
    controllHeight.forward();
    controllHeight.addListener(() {setState(() {});});
    animation = CurvedAnimation(parent: controllHeight  , curve: Curves.decelerate);



    controllOpacity = AnimationController(
        duration: Duration(milliseconds: 50),
        vsync: this,
    );
    controllOpacity.forward();
    controllOpacity.addStatusListener((status) {setState(() {});});


    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Builder(
        builder:(context)=>Scaffold(
          backgroundColor: Colors.white.withOpacity(animation.value),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 160,),
                    //For Logo and Apptitle............
                    Row(
                      children: [

                        Image(
                          image: AssetImage('images/icon.png'),
                          height: controllHeight.value * 120,
                          width: 120,

                        ),





                        SizedBox(
                          width: 250.0,
                          child: AnimatedTextKit(
                            animatedTexts: [
                              ColorizeAnimatedText(
                                'GAP - SHAP',
                                textStyle: TextStyle(
                                  fontSize: 40.0,
                                  fontFamily: 'Horizon',
                                  fontWeight: FontWeight.bold,
                                ),
                                colors: [
                                  Colors.greenAccent,
                                  Colors.transparent,
                                  Colors.blue,
                                  Colors.yellow,
                                  Colors.red,
                                ],
                              ),


                            ],
                            isRepeatingAnimation: true,
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        ),






                      ],
                    ),

                    SizedBox(height: 80,),
                    GestureDetector(
                      onTap : (){


                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));

                      },
                      child: ClayContainer(
                        //emboss: true,
                          width: 320,




                          height: 50,
                          spread: 4,
                          depth: 110,
                          borderRadius: 72,
                          child: Center(child: ClayText('New Account',color : Colors.blueAccent,style: TextStyle(
                              fontFamily: 'A',
                              fontSize: 18, letterSpacing: 1,color: Colors.orange),),)

                      ),
                    ),

                    SizedBox(height: 60,),
                    GestureDetector(
                      onTap : (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));

                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));

                      },
                      child: ClayContainer(
                        //emboss: true,
                          width: 320,




                          height: 50,
                          spread: 4,
                          depth: 110,
                          borderRadius: 72,
                          child: Center(child: ClayText('Sign In ',color : Colors.greenAccent,style: TextStyle(fontSize: 18, letterSpacing: 1,
                              fontFamily: 'A' ,color: Colors.orange),),)

                      ),
                    ),
                    SizedBox(height: 60,),
                    GestureDetector(
                      onTap : (){


                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgot_Password()));
                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));

                      },
                      child: ClayContainer(
                        //emboss: true,
                          width: 320,




                          height: 50,
                          spread: 4,
                          depth: 110,
                          borderRadius: 72,
                          child: Center(child: ClayText('Forgot Password',color : Colors.pink,style: TextStyle(fontSize: 18, letterSpacing: 1,color: Colors.greenAccent,
                          fontFamily: 'A'),),)

                      ),
                    ),


                  ],
                ),
              ),
            ),
          ),
        ),
      )
      );
  }
}



