import 'dart:io';

import 'package:crimo/misc/settings.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiRequest {
  static Future<String> get(String pointer, [String arg]) async {
    String url;
    if (arg != null) {
      url = Settings.apiLink + '/$pointer?$arg';
    } else {
      url = Settings.apiLink + '/$pointer';
    }
    try {
      final response = await http.get(url);
      return response.body;
    } catch (e) {
      print(e.message);
      return "{'success': false, 'message': '${e.message}'";
    }
  }

  static Future<String> post(dynamic body, String pointer, [String arg]) async {
    Map<String, String> headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    };
    String url;
    if (arg != null) {
      url = Settings.apiLink + '/$pointer?$arg';
    } else {
      url = Settings.apiLink + '/$pointer';
    }
    try {
      Response res = await http.post(url, headers: headers, body: body);
      return res.body;
    } catch (e) {
      return '{"success": false, "message": "${e.message}"}';
    }
  }
}
