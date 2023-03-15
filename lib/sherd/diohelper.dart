import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHelper {
  getRequest(String uri) async {
    try {
      var response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var responseBody=jsonDecode(response.body);
        return responseBody;
      } else {
        print('Error${response.statusCode}');
      }
    } catch (e) {
      print('Error Catch $e');
    }
  }

Future<dynamic>  postRequest(String uri,Map data) async {
    try {
      var response = await http.post(Uri.parse(uri),body: data);
      if (response.statusCode == 200) {
        var responseBody=jsonDecode(response.body);
        return responseBody;
      } else {
        print('Error${response.statusCode}');
      }
    } catch (e) {
      print('Error Catch $e');
    }
  }
}
