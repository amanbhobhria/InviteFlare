import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invite_flare/core_2/core/translations/local_keys.dart';

import '../values/app_global_values.dart';

Future<PickedFile?> imageFromCamera() async {
  var pickedFile = await ImagePicker()
      .pickImage(source: ImageSource.camera, imageQuality: 100);
  if (pickedFile == null) {
    showInSnackBar(message: strNoImage);
  } else {
    return cropImage(pickedFile.path);
  }
  return null;
}

/*=================================================================== Image Pick Using Gallery ===================================================*/

Future<PickedFile?> imageFromGallery() async {
  var pickedFile = await ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: 100);
  if (pickedFile == null) {
    showInSnackBar(message: strNoImage);
  } else {
    return cropImage(pickedFile.path);
  }
  return null;
}

Future<PickedFile?> cropImage(filePath) async {
  var croppedImage = await ImageCropper().cropImage(
    sourcePath: filePath,
    aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    // aspectRatioPresets: [CropAspectRatioPreset.original],
  );
  if (croppedImage == null) {
    showInSnackBar(message: strNoImage);
  } else {
    return PickedFile(croppedImage.path);
  }
  return null;
}
