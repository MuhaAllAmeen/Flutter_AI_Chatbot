import 'dart:convert';
import 'dart:io';

import 'package:mime/mime.dart' as mime;

String? getBase64FileExtension(String base64String) {
    var minimumBase64Length = (mime.defaultMagicNumbersMaxLength / 3).ceil() * 4;
  return mime.lookupMimeType(
    '',
    headerBytes: base64.decode(base64String.substring(0, minimumBase64Length)),
  );
}

String getB64DataFromImage(File imageFile){
  final bytes = imageFile.readAsBytesSync();
  final b64Image = base64Encode(bytes);
  return b64Image;
}

Map<String,String> getImageMetadata({required File imageFile}){
  final b64Image = getB64DataFromImage(imageFile);
  final mime = getBase64FileExtension(b64Image);
  return {
    'mimeType': mime!,
    'data':b64Image
  };
}