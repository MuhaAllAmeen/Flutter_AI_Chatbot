import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipe_ai/models/image_message_model.dart';
import 'package:recipe_ai/repos/AI_repo.dart';
import 'package:recipe_ai/utils/services/image_metadata.dart';
import 'package:recipe_ai/utils/services/image_picker.dart';

part 'image_ai_event.dart';
part 'image_ai_state.dart';

class ImageAiBloc extends Bloc<ImageAiEvent, ImageAiState> {
  ImagePick imagePick = ImagePick();
  File? imageFile;
  ImageAiBloc() : super(ImageAiInitial()) {
    on<UploadImageEvent>((event, emit) async{
      try{
        imageFile = await imagePick.selectImage(event.galleryOrCamera);
        emit(ImageAILoadingState(caption: 'Uploading...'));
        emit(ImageUploadedState(imageFile: imageFile));  
      }on Exception catch(_){
        emit(ImageAIFailedState(exception: 'Could Not Upload Image'));
      }
    });

    on<GenerateTextFromImage>((event, emit) async{
      List<ImageMessageModel> messages = [];
      emit(ImageAILoadingState(caption: 'Generating...'));
      if(event.imageFile==null || event.inputMessage.isEmpty){
        emit(ImageAIFailedState(exception: 'Empty Body'));
      }
      try{
        if(event.imageFile != null){
          final imageData = getImageMetadata(imageFile: event.imageFile!);  
          messages.add(ImageMessageModel(parts: [ImagePartModel(text:  event.inputMessage, inlineData: ImageDataModel(mimeType: imageData['mimeType']! ,data: imageData['data']!))]));
          final generatedText = await ChatRepo.imageTextGenerationRepo(messages);
          if (generatedText.isNotEmpty){
            messages.add(ImageMessageModel(parts: [ImagePartModel(text: generatedText, inlineData: ImageDataModel(mimeType: imageData['mimeType']! ,data: imageData['data']!))]));
            emit(ImageAISuccessState(generatedText: generatedText));
          }
        }
      }on Exception catch(_){
        emit(ImageAIFailedState(exception: 'Inavlid Response'));
      }     
    },);
  }
}
