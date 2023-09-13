import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class PatientInfoController extends GetxController {
  RxList<PlatformFile> file = <PlatformFile>[].obs;

  pickMultipleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      // type: FileType.custom,
      // allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (result == null) return;
    file.value = result.files;
    // result.paths.map((path) => PlatformFile(path!)).toList();
  }
}
