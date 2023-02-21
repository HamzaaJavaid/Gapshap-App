import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Forgot_Password extends StatefulWidget {
  const Forgot_Password({Key? key}) : super(key: key);

  @override
  State<Forgot_Password> createState() => _Forgot_PasswordState();
}

class _Forgot_PasswordState extends State<Forgot_Password> {

  Dialog alert_Dialog(String content , IconData icon){
    return Dialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        height: 160,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              child: Center(child: Text('WARNING',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.redAccent,fontFamily: 'A'),),),
              height: 60,
              color: Colors.white,
            ),
            Container(
              height: 80,
              width: 331,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: Colors.greenAccent,
              ),
              child: Row(
                children: [
                  SizedBox(width: 30,),
                  Icon(icon,color: Colors.redAccent,),SizedBox(width: 30,),
                  Text('$content',style: TextStyle(color: Colors.white,fontFamily: 'A',fontSize: 15),),
                ],
              ),

            ),

          ],
        ),
      ),
    );
  }

  Dialog Success_Dialog(String content , IconData icon){
    return Dialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        height: 160,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              child: Center(child: Text('Success',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.greenAccent,fontFamily: 'A'),),),
              height: 60,
              color: Colors.white,
            ),
            Container(
              height: 80,
              width: 331,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: Colors.greenAccent,
              ),
              child: Row(
                children: [
                  SizedBox(width: 30,),
                  Icon(icon,color: Colors.redAccent,),SizedBox(width: 30,),
                  Text('$content',style: TextStyle(color: Colors.white,fontFamily: 'A',fontSize: 15),),
                ],
              ),

            ),

          ],
        ),
      ),
    );
  }


  final auth = FirebaseAuth.instance;
  String  forgot_email ='cc';
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: 20,),
                  Row(children: [GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.greenAccent,
                      child: Icon(Icons.arrow_back,color: Colors.white,),
                    ),
                  ),],),

                  SizedBox(height: 40,),
                  Image(image: AssetImage('images/login.jpg'),height: 240,width: 400,),
                  SizedBox(height: 40,),
                  Padding(padding: EdgeInsets.all(40),
                    child: TextField(
                      onChanged: (values){
                        setState(() {
                          forgot_email = values;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter email ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 10,color: Colors.greenAccent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 2,color: Colors.greenAccent),
                        ),
                      ),
                    ),),
                  SizedBox(height: 0,),
                  Text('NOTE :Put that email on which you registered account\n            Check Inbox/Spam folder for Verification email ',style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 13
                  ),),
                  SizedBox(height: 20,),
                  MaterialButton(onPressed: () async{
                    print(forgot_email);


                    if(forgot_email=='cc'){

                      showDialog(context: context, builder: (context){
                        return alert_Dialog('Email is Empty', Icons.email_rounded);});

                    }

                    else if(!forgot_email.contains('@')){
                      showDialog(context: context, builder: (context){
                        return alert_Dialog('Invalid Email', Icons.alternate_email_outlined);});

                    }
                    else{

                      await auth.sendPasswordResetEmail(email: forgot_email);
                      showDialog(context: context, builder: (context){
                        return Success_Dialog('Email is Sent', Icons.email_rounded);});

                    }



                  },
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(width: 0,color: Colors.transparent),
                    ),
                    elevation: 8,

                    minWidth: 260,
                    height: 70,
                    color: Colors.greenAccent,
                    child: Text('Send Email ',style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'A',
                    ),),
                  ),
                  SizedBox(height: 30,),

                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
// Container(
// //color: Colors.greenAccent,
// width: 300,
// height:80,
// decoration: BoxDecoration(
// color: Colors.greenAccent.withOpacity(0.8),
// borderRadius: BorderRadius.all(Radius.circular(20)),
// ),
// child:Center(
// child: Text('    1).Enter Your Registered Email below\n\n   2).Check Inbox or Spam Folder for our   Email  ',
// style: TextStyle(
// fontSize: 14,
// fontFamily: 'A',
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
// )