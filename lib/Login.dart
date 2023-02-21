import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gapshap/DashBoard.dart';
import 'package:gapshap/RegistrationScreen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'ChatScreen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email = '';
  String password = '';
  final auth = FirebaseAuth.instance;
  late User user ;



  bool load = false;


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

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: load,
            child: Center(
              child: ListView(

                children: [

                  SizedBox(height: 40,),
                  Row(children: [
                    SizedBox(width: 20,),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.greenAccent,
                        child: MaterialButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                          },
                          child: Icon(Icons.arrow_back),
                        ),),
                  ],),

                  Image(image: AssetImage('images/login.jpg'),height: 230,width: 250,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      onChanged: (value){
                        email= value ;
                      },
                      decoration: InputDecoration(
                        //hintText: 'Enter Email : ',
                        label: Text('Enter Email '),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 20,color: Colors.greenAccent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 2,color: Colors.greenAccent),
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                   obscureText: true,
                      textAlign: TextAlign.center,
                      onChanged: (value){
                        password = value;
                      },
                      decoration: InputDecoration(
                        //hintText: 'Enter Email : ',
                          label: Text('Enter Password '),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 20,color: Colors.greenAccent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 2,color: Colors.greenAccent),
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80),
                    child: MaterialButton(

                      elevation: 10,
                      height: 60,
                      minWidth: 200,
                    splashColor: Colors.white,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                          width: 0,color: Colors.greenAccent,
                        )
                      ),


                      color: Colors.greenAccent,
                      onPressed: () async{

                        if(email==''){
                          print('Email is empty');

                          showDialog(context : context,  builder: (context) {
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
                                          Icon(Icons.email,color: Colors.redAccent,),SizedBox(width: 30,),
                                          Text('Email Field is Empty',style: TextStyle(color: Colors.white,fontFamily: 'A',fontSize: 15),),
                                        ],
                                      ),

                                    ),

                                  ],
                                ),
                              ),
                            );
                          }
                          );
                        }
                        else if(!email.contains('@')){
                          print('Invalid Email');
                           showDialog(context: context, builder: (context){
                           return alert_Dialog('Invalid Email', Icons.alternate_email_outlined);
                          });
                        }
                        else if(password==''){
                          print('Enter Password');
                          showDialog(context: context, builder: (context){
                            return alert_Dialog('Enter Password', Icons.password);
                          });
                        }
                        else if(password.length<7){
                          print('Password cant be less than ');
                          showDialog(context: context, builder: (context){
                            return alert_Dialog('Password Cant be less than 6 ', Icons.password);
                          });
                        }
                        else{

                          setState(() {
                            load = true;
                          });
                          final logged_in_user = await auth.signInWithEmailAndPassword(email: email, password: password);

                          if(logged_in_user!=null){

                            setState(() {
                              load = false;
                            });

                            showDialog(context: context, builder: (context)
                            {return Dialog(

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Container(
                                height: 160,
                                child: Column(
                                  children: [
                                    SizedBox(height: 20,),
                                    Container(
                                      child: Center(child: Text('WELCOME ', style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          color: Colors.lightGreen,
                                          fontFamily: 'A'),),),
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
                                          Icon(Icons.account_circle_outlined, color: Colors.white,),
                                          SizedBox(width: 30,),
                                          Text('Login Succesfully', style: TextStyle(
                                              color: Colors.white, fontFamily: 'A', fontSize: 15),),
                                        ],
                                      ),

                                    ),

                                  ],
                                ),
                              ),
                            );});
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));


                          }




                        }




                        },
                    child: Text('Log in '),

                    ),
                  ),

                  SizedBox(height: 60,),
                  Row(children: [
                    Expanded(child: Divider(
                      color: Colors.black,
                    )),
                    Text('Dont Have Account ? ',style: TextStyle(fontSize:13,fontFamily: 'A'),),
                  TextButton(child: Text('Sign Up',style: TextStyle(fontFamily: 'A',color: Colors.greenAccent,fontWeight: FontWeight.bold),),
                    onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));
                    },),
                    Expanded(child: Divider(
                      color: Colors.black,
                    )),
                               ],)



                ],
              ),
            ),
          ),
        )
      ),

    );
  }
}
