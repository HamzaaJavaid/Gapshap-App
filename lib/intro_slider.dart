import 'DashBoard.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Crousel extends StatelessWidget {
  const Crousel({Key? key}) : super(key: key);

  List<PageViewModel> getPages(){

    return [
      PageViewModel(

        bodyWidget: Text('\n\nThis App provide free chatting with your family as well as your friends',
       textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'A',
          fontSize: 18,
        ),
        ),
        image: Image.asset('images/create.jpg'),
        title: 'WELCOME TO GAP SHAP ',
        //body: '\n\nThis App provide free chatting with your family as well as your friends',
      ),
      PageViewModel(
        image: Image.asset('images/login.jpg'),
        title: 'SECURED AUTHENTICATION SYSTEM ',
       bodyWidget: Text('\n\nGAPSHAP provides fully functional and secured authentication\n system ',
         textAlign: TextAlign.center,
         style: TextStyle(
           fontFamily: 'A',
           fontSize: 20,
         ),
       ),
        //body: 'This App provide free chattin with your family members',
      ),
      PageViewModel(
        image: Image.asset('images/dashboard.jpg'),
        title: 'FREE CHATTING SERVICES ',
        bodyWidget: Text('\n\nGAPSHAP gives you access to free group chatting services\n',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'A',
            fontSize: 20,
          ),
        ),
        //body: 'This App provide free chatting with your family members',
      )
    ];
  }
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      next: Text('Next'),
      pages: getPages(),
      skip: Text('Skip'),
      showSkipButton: true,
      done: Text('Done'),
      onDone: (){

        Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
      },
    );
  }
}

