part of 'image_ai_bloc.dart';

@immutable
sealed class ImageAiState {}

final class ImageAiInitial extends ImageAiState {}

class ImageAISuccessState extends ImageAiState {
  final String generatedText;

  ImageAISuccessState({required this.generatedText});

}

class ImageUploadedState extends ImageAiState{
  final File? imageFile;

  ImageUploadedState({required this.imageFile});
}

class ImageAIFailedState extends ImageAiState{
  final String exception;

  ImageAIFailedState({required this.exception});
}

class ImageAILoadingState extends ImageAiState{
  final String caption;

  ImageAILoadingState({required this.caption}); 
}
