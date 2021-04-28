import 'dart:convert';
import 'package:http/http.dart' as http;

class InternetController {
  Future<dynamic> getData(url) async {
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      var jsonData = await jsonDecode(response.body);
      return jsonData;
    }
    return null;
  }
}