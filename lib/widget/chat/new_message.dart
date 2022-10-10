import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _enteredMessage = '';

  _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userDate = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(), // time call fun. provider from firestore
      'username': userDate['username'],
      'userId': user.uid,
      'image_url': userDate['image_url']
    });
    _controller.clear();
    setState(() {
      _enteredMessage='';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                labelText: 'Send a message...',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                  borderRadius: BorderRadius.circular(14)
                )),
            onChanged: (val) {
              setState(() {
                _enteredMessage = val;
              });
            },
          )),
          IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.send),
              disabledColor: Colors.grey[300],
              onPressed: () {
                _enteredMessage.trim().isEmpty ? null : _sendMessage();
              })
        ],
      ),
    );
  }
}
