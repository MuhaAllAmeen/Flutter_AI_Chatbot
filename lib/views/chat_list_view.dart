import 'package:flutter/material.dart';
import 'package:recipe_ai/models/chat_message_model.dart';

class ChatListView extends StatelessWidget {
  final List<ChatMessageModel>messages;
  const ChatListView({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: messages.length,
        itemBuilder:(context, index) {
          final role = messages[index].role;
          final text = messages[index].parts.first.text;
        return Container(
          margin: const EdgeInsets.only(bottom: 12,left: 10,right: 10),
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: role=='user'?Colors.pink[300]:Colors.pink[100],
          ),
          child: 
            Column(
              crossAxisAlignment: role=='user'?CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                Text(role == 'user'?'User':'AI',textAlign: TextAlign.center, style: TextStyle(color: role=='user'?Colors.white:Colors.blue,fontSize: 20,fontFamily: 'PlayfairDisplay',fontWeight: FontWeight.bold),),
                const SizedBox(height: 12,),
                Text(text,textAlign: role=='user'?TextAlign.end:TextAlign.start, style:const TextStyle(fontSize: 17,fontFamily: 'Quicksand',fontWeight: FontWeight.bold),),
              ],
            )
          );
      },);
  }
}