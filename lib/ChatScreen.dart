import 'dart:io';

import 'package:gapshap/Location services/location_fetch.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final auth = FirebaseAuth.instance;
  late User user ;
  final firestor = FirebaseFirestore.instance;
  late String message;
  final text_message_field_controller = TextEditingController();
  final search_converse_controller = TextEditingController();
  late final  search_field_message ;
final scroll_Controller = ScrollController();


  void logged_in_user (){
    final current_user = auth.currentUser;
    if(current_user!=null){
      user = current_user;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logged_in_user();
    //scroll_Controller.jumpTo(scroll_Controller.position.maxScrollExtent);

  }




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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child:  Container(
              color: Colors.white,
              child: Column(

                    children: [




                      SizedBox(height: 20,),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 1),
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Container(
                              width: 310,
                              height: 40,
                              color: Colors.white,
                              child: TextFormField(
                                onChanged: (value){
                                  setState(() {
                                  });
                                },

                                  controller: search_converse_controller,
                                  style: TextStyle(
                                    fontFamily: 'A',
                                    color: Colors.black54,
                                  ),
                                  decoration: InputDecoration(
                                      label: Text('Seacrh In Conversation',style: TextStyle(fontFamily: 'A',),),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        borderSide: BorderSide(width: 2 , color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        borderSide: BorderSide(width: 2 , color: Colors.greenAccent),
                                      )
                                  )

                              ),
                            ),
                            SizedBox(width: 0,),
                            Container(
                              color: Colors.white,
                              child: MaterialButton(
                                onPressed: () {
                                  print('LOGOUT');

                             Duration duration = Duration(seconds: 2);
                             sleep(duration);


                                  showDialog(context: context, builder: (context){
                                    return alert_Dialog('Logout Succesfully', Icons.logout);});

                                  auth.signOut();
                              Navigator.pop(context);
                                },
                                child: Icon(Icons.logout,size:40,color: Colors.greenAccent,),
                              )
                            )
                          ],
                        )

                      ),
                      Flexible(
                        child: Container(
                          width: 400,
                          height: 600,
                          color: Colors.white,
                          child: Stack(
                            children: [
                              StreamBuilder(
                                stream: firestor.collection('Messages').orderBy('time').snapshots(),
                                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                                  if(snapshot.connectionState== ConnectionState.waiting){
                                    return Center(child: CircularProgressIndicator());
                                  }
                                  return snapshot.hasData ?
                                  ListView.builder(

                                      controller: scroll_Controller,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context,index){

                                        String message_from_user = snapshot.data!.docs[index]['message'];
                                        String user_email  = snapshot.data!.docs[index]['sender'];

                                        if(search_converse_controller.text.isEmpty){
                                         // scroll_Controller.jumpTo(scroll_Controller.position.maxScrollExtent);
                                          return   Message_Design_Tile(message_from_user,user_email,user.email==user_email);

                                        }
                                        else if(message_from_user.toLowerCase().contains(search_converse_controller.text.toLowerCase())){
                                          //scroll_Controller.jumpTo(scroll_Controller.position.maxScrollExtent);
                                          return   Message_Design_Tile(message_from_user,user_email,user.email==user_email);

                                        }
                                        else{
                                          //scroll_Controller.jumpTo(scroll_Controller.position.maxScrollExtent);
                                          return Container();
                                        }

                                      }

                                  ) : Container();


                                },


                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(

                                          onTap : (){
                                            scroll_Controller.jumpTo(scroll_Controller.position.maxScrollExtent);
                                          },
                                          child: CircleAvatar(
                                            backgroundColor : Colors.greenAccent.shade100,
                                            child :Icon(Icons.arrow_downward,color: Colors.white,),
                                          ),
                                        )
                                      ],
                                    )
                                  ],)

                            ],
                          )
                        ),
                      ),
                      SizedBox(height: 10,),

                      Row(

                        children: [
                          GestureDetector(
                            onTap: ()  async{

                              geolocator g =  geolocator() ;
                               await g.get_current_location();

                               // print(g.city_name);
                               // print(g.weather_description);
                               // print(g.city_temp);
                               // print(g.country);
                               // print('WELCOME TO THE PARTY');


                              String mess = '${g.city_name}\n${g.weather_description}\n${g.city_temp} C\n${g.country}';
                              firestor.collection('Messages').add({
                                'sender':user.email,
                                'message':mess,
                                'time':DateTime.now(),
                              });

                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.greenAccent,
                              child: Icon(Icons.location_on,color: Colors.white,),
                            ),
                          ),
                          Expanded(
                              child:TextField(
                                controller: text_message_field_controller,
                                onChanged: (value){
                                  message= value;

                                },
                                decoration: InputDecoration(
                                    hintText: 'Your Message',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(width: 2 , color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(width: 2 , color: Colors.greenAccent),
                                    )                        ),
                              )
                          ),
                          GestureDetector(
                            onTap: ()async{
                             await firestor.collection('Messages').add({
                                'sender':user.email,
                                'message':message,
                                'time':DateTime.now(),

                              }
                              );
                              text_message_field_controller.clear();
                              scroll_Controller.jumpTo(scroll_Controller.position.maxScrollExtent);

                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.greenAccent,
                              child: Icon(Icons.send,color: Colors.white,),
                            ),
                          ),
                        ],
                      ),






                    ],
                  ),
            ),


            )
          ),
        ),

    );
  }
}




class Message_Design_Tile extends StatelessWidget {
  Message_Design_Tile(this.text , this.sender ,this.verify_account);

  final text ;
  final sender;
  final bool verify_account;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: verify_account ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Container(

              padding: EdgeInsets.all(17),
              decoration: BoxDecoration(
                  color: verify_account ? Colors.greenAccent.shade100 : Colors.white.withOpacity(0.9),
                borderRadius: verify_account ? BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ) : BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  verify_account ? BoxShadow(
                    color: Colors.grey.shade400,
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(1,3),
                  ):BoxShadow(
                    color: Colors.grey.shade400,
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0,3),
                  )
                ]

              ),
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'A',
                ),
              ),

            ),
          ),
          SizedBox(height: 3,),
          Padding(

            padding: EdgeInsets.all(0),
            child: Container(
              child: Text(
                verify_account ? '' :  '${sender.toString().substring(0,sender.toString().length-10)}' ,
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'A',
                  color: Colors.cyan
                ),
              ),

            ),

          )

        ],
      ),

    );
  }
}


//ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ),ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ),ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ),ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ),
// ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ),ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ),ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ), ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ),
// ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ),ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ),ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ), ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ),
// ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ),ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ),ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ),ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ),
// ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ),ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ),ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
// ),
// ListTile(
//   title: Text('THIS IS HAMZA'),
//   subtitle: Text('hamza javaid'),
