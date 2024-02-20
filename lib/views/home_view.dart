import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_ai/bloc/chat_bloc_bloc.dart';
import 'package:recipe_ai/models/chat_message_model.dart';
import 'package:recipe_ai/views/chat_list_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _textEditingController = TextEditingController();
  final ChatBlocBloc chatBloc = ChatBlocBloc();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBlocBloc, ChatBlocState>(
        bloc: chatBloc,
        listener: (context, state) {
        },
        builder: (context, state) {
          switch(state.runtimeType){
            case ChatSuccessState:
              List<ChatMessageModel> messages = (state as ChatSuccessState).messages;
              return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  opacity: 0.85,
                    image: AssetImage('assets/cooking_bg_edited.jpg'),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 100,
                  color: Colors.white,
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recipe.AI',
                        style: TextStyle(
                            fontSize: 30,color: Colors.pinkAccent, fontWeight: FontWeight.bold,fontFamily: 'ProtestRiot'),
                      ),
                      Icon(
                        Icons.food_bank_outlined,
                        color: Colors.pink,
                        size: 40,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ChatListView(messages: messages,)
                ),
                if(chatBloc.generating) Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,           
                      child: Lottie.asset('assets/loading_animation_2.json')),
                    const SizedBox(width: 20,),
                    const Text('Generating...',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                  ],
                ), 
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                            controller: _textEditingController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                  hintText: 'Enter the prompt',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  fillColor: Colors.pink[100],
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColor))))),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap:() {
                          if(_textEditingController.text.isNotEmpty){
                            final text = _textEditingController.text;
                            _textEditingController.clear();
                            chatBloc.add(ChatGenerateNewTextMessage(inputMessage: text));
                          }
                        },
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Center(
                              child: Icon(
                                Icons.send,
                                color: Colors.pink[400],
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
          default:
            return const SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(color: Colors.pink,),
            );
          }
        },
      ),
    );
  }
}
