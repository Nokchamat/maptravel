import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static final ImagePickerService _imagePickerService =
      ImagePickerService._internal();

  factory ImagePickerService() {
    return _imagePickerService;
  }
  ImagePickerService._internal();

  final ImagePicker _picker = ImagePicker();

  Future<List<XFile>> pickImages() async {
    try {
      final pickedFiles = await _picker.pickMultiImage();
      return pickedFiles;
    } catch (e) {
      print('ImagePickerService: $e');
      return [];
    }
  }

  Future<XFile?> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      return pickedFile;
    } catch (e) {
      print('ImagePickerService: $e');
      return null;
    }
  }

}