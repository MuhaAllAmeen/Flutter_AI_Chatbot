import 'dart:io';

import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final File? imageFile;

  const ImageView({
    Key? key,
    required this.imageFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(child: Image.file(imageFile!)),
    );
  }
}
