import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FileHandler {
  static Future<String> get _localPath async {
    if (await Permission.storage.request().isGranted) {
      var path = await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS);
      return path; // /storage/emulated/0
    } else {
      return null;
    }
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/expense_data.json');
  }

  static Future<String> readFromFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    try {
      File file = File(result.files.single.path);
      String contents = await file.readAsString();
      // List parsed = jsonDecode(contents);
      // _expenseData.addDataToListFromJson(jsonDecode(contents));
      return contents;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<File> writeToFile(String data) async {
    if (await Permission.storage.request().isGranted) {
      final file = await _localFile;
      return file.writeAsString(data);
    } else {
      return null;
    }

    // Write the file.
  }
}
