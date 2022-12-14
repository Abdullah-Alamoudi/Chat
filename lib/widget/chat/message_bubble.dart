import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  //const MessageBubble({Key? key}) : super(key: key);
  final Key? key;
  final String message;
  final String userName;
  final String image_url;
  final bool isMe;


   MessageBubble(this.message,this.userName,this.image_url,this.isMe,{ this.key}) ;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
      mainAxisAlignment: isMe?MainAxisAlignment.end :MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: !isMe?Colors.grey[300]: Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
              bottomLeft: !isMe?Radius.circular(0):Radius.circular(14),
              bottomRight: isMe?Radius.circular(0):Radius.circular(14)
            )
          ),
          width: 160,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
          child: Column(
           crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
           children: [
             Text(userName,style: TextStyle(
               fontWeight: FontWeight.bold,
               color: !isMe?Colors.black:Theme.of(context).accentTextTheme.headline6!.color,
             ),),
             Text(message,style: TextStyle(
               color: !isMe?Colors.black:Theme.of(context).accentTextTheme.headline6!.color,
             ),
             textAlign: isMe?TextAlign.end:TextAlign.start,
             ),
             
           ],
              ),
        )])
      ,Positioned(
         top:null,
         left: isMe?240:135,
         //right: !isMe?30:null,
        child: CircleAvatar(backgroundImage: NetworkImage(image_url),)),
      ],
      
    );
  }
}