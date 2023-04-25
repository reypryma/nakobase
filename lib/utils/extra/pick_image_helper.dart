import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


Future<String?> pickImageToBase64() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    final imageInBase64 = base64Encode(File(image.path).readAsBytesSync());
    return imageInBase64;
  } else {
    return null;
  }
}
