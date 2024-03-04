import 'dart:io';

import 'package:flutter/material.dart';
class ImageComp extends StatelessWidget {
  final File? imageFile;

  const ImageComp({Key? key, this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageFile != null
        ? Image.file(imageFile!)
        : Container();
  }
}
