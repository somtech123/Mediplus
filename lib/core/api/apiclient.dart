import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../env/private_key.dart';

class ApiClient {
  Future<Uint8List> loadAssetImage(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List();
  }

  Future<Uint8List> removeImageBackground(String imagePath) async {
    final imageBytes = await loadAssetImage(imagePath);
    var request = http.MultipartRequest(
        'POST', Uri.parse("https://api.remove.bg/v1.0/removebg"));
    request.files
        .add(await http.MultipartFile.fromBytes("image_file", imageBytes));
    request.headers.addAll({"X-API-Key": PrivateKey.removeBgPrivateKey});

    final response = await request.send();
    if (response.statusCode == 200) {
      http.Response imgRes = await http.Response.fromStream(response);

      debugPrint(imgRes.bodyBytes.toString());
      return imgRes.bodyBytes;
    } else {
      throw Exception("Error occurred with response ${response.statusCode}");
    }
  }
}
