import 'package:dio/dio.dart';
import 'package:recipe_ai/models/chat_message_model.dart';
import 'package:recipe_ai/models/image_message_model.dart';
import 'package:recipe_ai/utils/constants.dart';

class ChatRepo{
  static Future<String> chatTextGenerationRepo(List<ChatMessageModel> previousMessages) async{
    Dio dio = Dio();
    try{
    final response = await dio.post("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=$API_KEY",
      data: {
  "contents": previousMessages.map((e) => e.toMap()).toList(),
  "generationConfig": {
    "temperature": 0.9,
    "topK": 1,
    "topP": 1,
    "maxOutputTokens": 2048,
    "stopSequences": []
  },
  "safetySettings": [
    {
      "category": "HARM_CATEGORY_HARASSMENT",
      "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
      "category": "HARM_CATEGORY_HATE_SPEECH",
      "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
      "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
      "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
      "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
      "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    }
  ]
});
  if(response.statusCode! >= 200 && response.statusCode! < 300){
    return response.data['candidates'].first['content']['parts'].first['text'];
  }else{
    return 'error';
  }
    }catch(e){
      print('exception $e');
    }
    return '';
  }

  static Future<String> imageTextGenerationRepo(List<ImageMessageModel> previousMessages) async{
    Dio dio = Dio();
    try{
      final response = await dio.post('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro-vision-latest:generateContent?key=$API_KEY'
        ,data:{
          "contents":previousMessages.map((e) => e.toMap()).toList(),
          "generationConfig": {
          "temperature": 0.9,
          "topK": 32,
          "topP": 1,
          "maxOutputTokens": 4096,
          "stopSequences": []
        },
        "safetySettings": [
          {
            "category": "HARM_CATEGORY_HARASSMENT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_HATE_SPEECH",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          }
        ]
        });
        if(response.statusCode! >= 200 && response.statusCode! < 300){
          return response.data['candidates'].first['content']['parts'].first['text'];
        }else{
          return 'error';
        }   
    }catch(e){
      print('exception $e');
      rethrow;
    }
  }
}