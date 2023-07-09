import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<Uint8List> removeImageBackground(String imagePath) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("https://api.remove.bg/v1.0/removebg"));
    request.files
        .add(await http.MultipartFile.fromPath("image_file", imagePath));
    request.headers.addAll({"X-API-Key": "3k3mfwoerzZUA9uXSHyReeRX"});

    final response = await request.send();
    if (response.statusCode == 200) {
      http.Response imgRes = await http.Response.fromStream(response);
      return imgRes.bodyBytes;
    } else {
      throw Exception("Error occurred with response ${response.statusCode}");
    }
  }
}
