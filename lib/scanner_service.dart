import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ScannerService {
  final textRecognizer = TextRecognizer();

  Future<String> scanImage() async {
    final XFile? picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked == null) return '';
    final inputImage = InputImage.fromFile(File(picked.path));
    final RecognizedText result = await textRecognizer.processImage(inputImage);
    return result.text.toLowerCase();
  }
}
