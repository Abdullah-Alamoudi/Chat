import 'package:chat/widget/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: ((context, AsyncSnapshot snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final doc = snapShot.data.docs;
          final user=FirebaseAuth.instance.currentUser;
          return ListView.builder(
              reverse: true,
              itemCount: doc.length,
              itemBuilder: (ctx, index) => MessageBubble(
                    doc[index]['text'],
                    doc[index]['username'],
                    doc[index]['image_url'],
                    doc[index]['userId']==user!.uid,
                    //key: ValueKey(doc[index].documentID),
                  ));
        }));
  }
}
