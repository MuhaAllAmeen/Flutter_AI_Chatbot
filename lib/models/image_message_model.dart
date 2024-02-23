import 'dart:convert';

class ImageMessageModel {
  final List<ImagePartModel> parts;

  ImageMessageModel({required this.parts});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'parts': parts.map((x) => x.toMap()).toList().first,
    };
  }

  factory ImageMessageModel.fromMap(Map<String, dynamic> map) {
    return ImageMessageModel(
      parts: List<ImagePartModel>.from((map['parts'] as List<int>).map<ImagePartModel>((x) => ImagePartModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageMessageModel.fromJson(String source) => ImageMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ImagePartModel {
  final String text;
  final ImageDataModel inlineData;

  ImagePartModel({required this.text, required this.inlineData});

  List<Map<String, dynamic>> toMap() {
    List<Map<String, dynamic>> partsList = [];
    partsList.add({'text': text});
    partsList.add({'inlineData': inlineData.toMap()});
    return partsList;
  }


  factory ImagePartModel.fromMap(Map<String, dynamic> map) {
    return ImagePartModel(
      text: map['text'] as String,
      inlineData: ImageDataModel.fromMap(map['inlineData'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImagePartModel.fromJson(String source) => ImagePartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ImageDataModel {
  final String mimeType;
  final String data;

  ImageDataModel({required this.mimeType, required this.data});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mimeType': mimeType,
      'data': data,
    };
  }

  factory ImageDataModel.fromMap(Map<String, dynamic> map) {
    return ImageDataModel(
      mimeType: map['mimeType'] as String,
      data: map['data'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageDataModel.fromJson(String source) => ImageDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
