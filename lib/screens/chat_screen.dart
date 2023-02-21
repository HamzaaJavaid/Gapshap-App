import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:gapshap/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  final load = false ;
   final firestor = FirebaseFirestore.instance;

  
  final autho  = FirebaseAuth.instance;
     late User user  ;



    String text_message = '';

    void logginuser() {
      final Userr =   autho.currentUser;
      if(Userr!=null){
        user = Userr;

      }

    }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logginuser();
  }

  String hello(){

      String x  = 'sddd';
      return x;


  }





  final search = TextEditingController();
  final scroll = ScrollController();
    final bottomcontroller = TextEditingController();
    dynamic t(){

      try{
        return ListTile(
            title: Text('d'));
      }
      catch(e){
        print(e);
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {

                autho.signOut();
  
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            SizedBox(height: 20,),
            Padding(
                 padding: EdgeInsets.symmetric(horizontal: 10),
                 child: TextFormField(
             controller: search,
                   decoration: InputDecoration(
                     hintText: 'Search In conversation',
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(16)),
                     ),

                   ),
                   onChanged: (value){
               setState(() {

               });
                   },
           ),
               ),
             Expanded(

                 child: StreamBuilder(
                   stream: firestor.collection('Message').orderBy('time').snapshots(),
                   builder: (context , AsyncSnapshot<QuerySnapshot>snapshot){

                     if(snapshot.connectionState == ConnectionState.waiting){
                       return Center(child: const CircularProgressIndicator());
                     }

                     return snapshot.hasData ?
                     ListView.builder(

                         controller: scroll,
                         //reverse: true,
                         itemCount: snapshot.data!.docs.length,
                         itemBuilder: (context , index){

                           String message = snapshot.data!.docs[index]['text'];
                           String sender = snapshot.data!.docs[index]['sender'];
                           //String time = snapshot.data!.docs[index]['time'];

                           if(search.text.isEmpty){
                             return MessageBubble(message, sender, sender.toString()==user.email);
                           }
                           else if(message.toLowerCase().contains(search.text.toLowerCase())){
                             return MessageBubble(message, sender, sender.toString()==user.email);

                           }
                           else{
                             return Container();
                           }

                         }
                     ) : Container();


                   },

                 )

             ),




                 Container(
                  decoration: kMessageContainerDecoration,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                        
                          controller: bottomcontroller,
                          onChanged: (value) {

                            text_message = value;


                          },
                          decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          scroll.jumpTo(scroll.position.maxScrollExtent);
                          bottomcontroller.clear();
                          firestor.collection('Message').add({

                            'text' : text_message,
                            'sender': user.email,
                            'time':DateTime.now(),

                          }).then((value) => Fluttertoast.showToast(msg: 'Message Send',
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.greenAccent,
                            textColor: Colors.black,
                          ),);

                          scroll.jumpTo(scroll.position.maxScrollExtent);

             //Implement send functionality.
                        },
                        child: Text(
                          'Send',
                          style: kSendButtonTextStyle,
                        ),
                      ),

                    ],
                  ),
                ),



          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: 60),
        child: FloatingActionButton(
          backgroundColor: Colors.cyan.shade200,
          child: Icon(Icons.arrow_downward),
          onPressed: (){

             scroll.jumpTo(scroll.position.maxScrollExtent,


            );

          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );

  }
}



class MessageBubble extends StatelessWidget {

  MessageBubble(this.message , this.sender , this.me);

  final message ;
  final sender ;
  final me ;



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
    Padding(
    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
    child: Column(
      children: [



                me ?   Text('') : Text(
        //          sender.toString().substring(6 , sender.toString().length-2),
           sender,
                  //'$sender ${DateTime.fromMillisecondsSinceEpoch(time.seconds *1000)}',
                  style: TextStyle(
                      fontSize: 10
                  ),
                ),
                 Material(
            color: me ? Colors.blue.shade200 : Colors.white,
            borderRadius: me ? BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ) : BorderRadius.only(
    topRight: Radius.circular(20),
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
    ),
            elevation: 8,
            shadowColor: Colors.black,
            child: Padding(
              padding: EdgeInsets.all(17),
              child:Text(
                //message.toString().substring(6,message.toString().length-2),
                message,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),

            )
        ),

      ],
    )
    ),



      ],
    );
  }
}


























//
// Expanded(
// child: FirebaseAnimatedList(
// query: firestor,
// defaultChild: Text('Loading'),
// itemBuilder: (context,snapshot,animation  , index){
//
// final title = snapshot.child('message:').value.toString();
// if(search.text.isEmpty){
// return ListTile(
// title: Text(snapshot.child('message:').value.toString(),),
// subtitle:  Text(snapshot.child('sender:').value.toString()),
//
//
// );
// }
// else if (title.toLowerCase().contains(search.text.toLowerCase().toString())){
// return ListTile(
// title: Text(snapshot.child('message:').value.toString() ),
// subtitle:  Text(snapshot.child('sender:').value.toString()),
// trailing: Text(snapshot.child('time:').value.toString()),
//
// );
//
// }
// else{
// return Container();
// }
// })),