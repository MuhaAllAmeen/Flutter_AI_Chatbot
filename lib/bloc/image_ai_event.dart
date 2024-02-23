part of 'image_ai_bloc.dart';

@immutable
sealed class ImageAiEvent {}

class UploadImageEvent extends ImageAiEvent{
  final GalleryOrCamera galleryOrCamera;

  UploadImageEvent({required this.galleryOrCamera});
}

class GenerateTextFromImage extends ImageAiEvent{
  final String inputMessage;
  final File? imageFile;

  GenerateTextFromImage({required this.inputMessage, required this.imageFile});
}