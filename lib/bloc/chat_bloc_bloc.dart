import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipe_ai/models/chat_message_model.dart';
import 'package:recipe_ai/repos/AI_repo.dart';

part 'chat_bloc_event.dart';
part 'chat_bloc_state.dart';

class ChatBlocBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
  bool generating = false;
  List<ChatMessageModel> messages = [];
  ChatBlocBloc() : super(ChatSuccessState(messages: [])) {
      on<ChatGenerateNewTextMessage>((event, emit) async{
        messages.add(ChatMessageModel(role: 'user', parts: [ChatPartModel(text: event.inputMessage)]));
        emit(ChatSuccessState(messages: messages));
        generating = true;
        final generatedText = await ChatRepo.chatTextGenerationRepo(messages);
        if(generatedText.isNotEmpty){
          messages.add(ChatMessageModel(role: 'model', parts: [ChatPartModel(text: generatedText)]));
        emit(ChatSuccessState(messages: messages));
        }
        generating = false;
      });

  }
}
