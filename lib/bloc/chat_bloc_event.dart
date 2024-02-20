part of 'chat_bloc_bloc.dart';

@immutable
sealed class ChatBlocEvent {}

class ChatGenerateNewTextMessage extends ChatBlocEvent{
  final String inputMessage;

  ChatGenerateNewTextMessage({required this.inputMessage});

}
