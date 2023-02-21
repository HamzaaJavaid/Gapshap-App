import 'package:gapshap/ChatScreen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {


  bool load = false ;
  final auth = FirebaseAuth.instance;
   String email_by_user  ='';
   String password_by_user = '';
   String confirm_password = '';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
            child: ModalProgressHUD(
              inAsyncCall: load,
              child: Center(
                child: ListView(

                  //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      // Flexible(
                      //     fit: FlexFit.tight,
                      //     child: SizedBox(height: 30,)),
                      // Flexible(
                      //   child: Row(children: [
                      //     Flexible(
                      //       child: CircleAvatar(child: Icon(Icons.arrow_back),
                      //         radius: 30,
                      //         backgroundColor: Colors.greenAccent,),
                      //     ),
                      //   ],),
                      // ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          SizedBox(width: 17,),
                          CircleAvatar(
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back),
                            ),

                            backgroundColor: Colors.greenAccent,
                            radius: 30,
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 130),
                        child: Image(
                          image: AssetImage('images/icon.png'),
                          height: 150,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(

                          onChanged: (value){

                            email_by_user = value;


                          },

                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'A',
                          ),

                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Enter Your Email',
                            hintStyle: TextStyle(
                              color: Colors.grey.withOpacity(0.5),


                            ),

                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(width: 20, color: Colors
                                  .pink),


                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(22)),
                              borderSide: BorderSide(width: 2, color: Colors
                                  .greenAccent),
                            ),


                          ),

                        ),
                      ),
                      SizedBox(height: 30,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(

                          onChanged: (value){
                            password_by_user = value;
                          },
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'A',
                          ),
                          obscureText: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'Enter Your Password',
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(0.5)
                              ),
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    20)),
                                borderSide: BorderSide(width: 20, color: Colors
                                    .pink),

                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    22)),
                                borderSide: BorderSide(width: 2, color: Colors
                                    .greenAccent),
                              )

                          ),

                        ),
                      ),
                      SizedBox(height: 30,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          onChanged: (value){
                            confirm_password = value;
                          },

                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'A',
                          ),

                          obscureText: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(0.5)
                              ),
                              labelText: 'Confirm your Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    20)),
                                borderSide: BorderSide(width: 20, color: Colors
                                    .pink),

                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    22)),
                                borderSide: BorderSide(width: 2, color: Colors
                                    .greenAccent),
                              )

                          ),

                        ),
                      ),
                      SizedBox(height: 30,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 90),
                        child: MaterialButton(
                            height: 50,
                            minWidth: 220,
                            elevation: 13,

                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            child: Text('Register'),

                            color: Colors.greenAccent,
                            onPressed: () async{


                              //LOGIC
                              //Put alert dialogs here............
                              if(email_by_user==''){
                                print('No email');
                                showDialog(context: context, builder: (context){
                                  return alert_Dialog('No Email', Icons.alternate_email_outlined);
                                });
                              }
                              else if(!email_by_user.contains('@')){
                               print('Invalid Email');
                               showDialog(context: context, builder: (context){
                                 return alert_Dialog('Invalid Email', Icons.alternate_email_outlined);
                               });
                              }
                              else if(password_by_user=='' && confirm_password==''){
                                print('password not entered');
                                showDialog(context: context, builder: (context){
                                  return alert_Dialog('Enter a Valid Password', Icons.password);
                                });

                              }
                              else if(password_by_user.length<4 && confirm_password.length<4){
                                print('Password must be greater than 3');
                                showDialog(context: context, builder: (context){
                                  return alert_Dialog('Password Cant be less than 3 ', Icons.password);
                                });
                              }
                              else if(password_by_user==confirm_password){
                                print('Account created');


                                setState(() {
                                  load=true;
                                });
                                final dataa = await auth.createUserWithEmailAndPassword(email: email_by_user, password: password_by_user);
                                if(dataa!=null){



                                  setState(() {
                                    load=false;
                                  });
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));


                                }



                                    }
                              else if(password_by_user!=confirm_password){
                                print('Password Mismatch');
                                showDialog(context: context, builder: (context){
                                  return alert_Dialog('Password Mis-Match', Icons.password);
                                });
                              }
                              else {
                                showDialog(context: context, builder: (context){
                                  return alert_Dialog('Error .... Check Credentials', Icons.error);
                                });

                              }

                              //Firebase authentication specific area



                            }),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(child: Divider(
                            thickness: 0,
                            color: Colors.black,


                          )),
                          SizedBox(width: 5,),
                          Text('Already Have An Account ? ',
                            style: TextStyle(fontFamily: 'A', fontSize: 10),),
                          TextButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => Login()));
                          },
                              child: Text('LOG-IN', style: TextStyle(
                                  fontFamily: 'A',
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold),)),
                          SizedBox(width: 0,),
                          Expanded(child: Divider(
                            thickness: 0,
                            color: Colors.black,


                          )),


                        ],),
                      SizedBox(height: 5,),
                      Row(children: [

                        SizedBox(width: 90,),
                        Icon(Icons.facebook, size: 40, color: Colors.blueAccent,),
                        SizedBox(width: 40,),
                        Icon(Icons.g_mobiledata, size: 40, color: Colors.black),
                        SizedBox(width: 40,),
                        Icon(Icons.gite_outlined, size: 40,
                          color: Colors.purpleAccent,),

                      ],)
                      //-------------------------------------
                      // Flexible(child: TextButton(onPressed: (){}, child: Text('Forgot password'))),
                      // Flexible(
                      //     fit: FlexFit.tight,
                      //     child: SizedBox(height: 5,)),
                      // Flexible(
                      //     fit: FlexFit.tight,
                      //     child: SizedBox(height: 5,)),


                    ]
                ),

              ),
            ),

          )

      ),
    );
  }
}
