import 'dart:io';

import 'package:image_picker/image_picker.dart';

enum GalleryOrCamera{gallery,camera}

class ImagePick{
  bool isImageSelected = false;

  static final ImagePick _singleton = ImagePick._internal();

  factory ImagePick() {
    return _singleton;
  }

  ImagePick._internal();

  Future<File?> selectImage(GalleryOrCamera galleryOrCamera) async{
  try{
    final pickedImage = await ImagePicker().pickImage(source: galleryOrCamera == GalleryOrCamera.gallery?ImageSource.gallery:ImageSource.camera);
    if (pickedImage!=null){
      isImageSelected = true;
      return File(pickedImage.path);
    }else{
      return null;
    }
  }catch(e){
    print('exception $e');
    return null;
  }
  }
}

