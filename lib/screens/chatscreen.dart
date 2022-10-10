import 'package:chat/widget/chat/message.dart';
import 'package:chat/widget/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text('Flutter chat'),
        actions: [
          DropdownButton<dynamic>(
            icon: Icon(Icons.more_vert,color: Theme.of(context).primaryIconTheme.color,),
            items: [
              DropdownMenuItem(child: Row(
                children: [
                  Icon(Icons.exit_to_app),
                  SizedBox(width: 8,),
                  Text('Logout')
                ],
              ),
              value: 'Logout',
              ),
              
            ],
             onChanged: (selectvalue){
              if(selectvalue=='Logout'){
                  FirebaseAuth.instance.signOut();
              }
             })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Message()),
            NewMessage()
          ],
        ),
      ),
    );
    
    
  }
}
