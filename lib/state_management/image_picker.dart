import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImageProvider extends StateNotifier<String?>{
  ImageProvider() : super(null);

  Future<void> getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      state = image.path;
    }
  }
}

final imageProvider = StateNotifierProvider<ImageProvider, String?>((ref) => ImageProvider());