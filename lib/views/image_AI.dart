import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_ai/bloc/image_ai_bloc.dart';
import 'package:recipe_ai/utils/helpers/loading.dart';
import 'package:recipe_ai/utils/services/image_picker.dart';

class ImageAI extends StatefulWidget {
  const ImageAI({super.key});

  @override
  State<ImageAI> createState() => _ImageAIState();
}

class _ImageAIState extends State<ImageAI> {
  final TextEditingController textEditingController = TextEditingController();
  final ImageAiBloc imageAiBloc = ImageAiBloc();
  File? imageFile;
  String? generatedText;
  final LoadingOverlay _loadingOverlay = LoadingOverlay();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ImageAiBloc, ImageAiState>(
        bloc: imageAiBloc,
        listener: (context, state) async{
          if (state is ImageUploadedState) {
            imageFile = state.imageFile;
            _loadingOverlay.hide();
          } else if (state is ImageAISuccessState) {
            generatedText = state.generatedText;
            _loadingOverlay.hide();
          } else if (state is ImageAILoadingState){
            _loadingOverlay.show(context,state.caption);
          } else if (state is ImageAIFailedState){
            _loadingOverlay.hide();
            showDialog(context: context, builder:(context) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: 180,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.pink[300],
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.exception,style:const TextStyle(fontSize: 25),overflow: TextOverflow.clip,),
                        TextButton(onPressed:() {
                          Navigator.of(context).pop();
                        }, child: const Text('Try Again',style: TextStyle(color: Colors.white),))
                      ],
                    ),
                  ),
                ),
              );
            },);
          }
          else{
            _loadingOverlay.hide();
          }
        },
        builder: (context, state) {
              return Container(
                height: double.maxFinite,
                width: double.maxFinite,
                decoration: BoxDecoration(color: Colors.pink[50]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: 100,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Recipe.AI',
                                style: TextStyle(
                                fontSize: 30,color: Colors.pinkAccent, fontWeight: FontWeight.bold,fontFamily: 'ProtestRiot'),
                              ),
                              Text('ImageBot',style: TextStyle(fontSize: 17,color: Colors.pink),)
                            ],
                          ),
                          Icon(Icons.food_bank_outlined,color: Colors.pink, size: 50,)
                        ],
                      ),
                    ),
                    if (imageFile!=null)
                      Expanded(
                        child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                        alignment: Alignment.center,
                        height: 250,
                        child: Image.file(imageFile!),
                                            ),
                      ), 
                      // },
                    // ),
                    if (generatedText!=null)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                        child: Text(generatedText!,style: const TextStyle(fontSize: 20),),
                      ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 5.0,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          controller: textEditingController,
                          maxLines: null,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                imageAiBloc.add(GenerateTextFromImage(
                                    inputMessage: textEditingController.text,
                                    imageFile: imageFile));
                              },
                              child: const Text('Generate',style: TextStyle(fontSize: 25,color: Colors.pink),)),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    imageAiBloc.add(UploadImageEvent(
                                        galleryOrCamera: GalleryOrCamera.gallery));
                                  },
                                  icon: const Icon(Icons.add,color: Colors.pink,)
                              ),
                              IconButton(
                              onPressed: () async {
                                imageAiBloc.add(UploadImageEvent(
                                    galleryOrCamera: GalleryOrCamera.camera));
                              },
                              icon: const Icon(Icons.camera_alt_outlined,color: Colors.pink,))
                            ],
                          ),                         
                        ],
                      ),
                    )
                  ],
                ),
              );
        },
      ),
    );
  }
}
