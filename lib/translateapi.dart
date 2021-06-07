import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class translateApi {
  static const _api_key = '515b8b336amsh2436fb4f5ef076ep184143jsn8d433aaad72f';
  // Base API url
  static const String _baseUrl = "systran-systran-platform-for-language-processing-v1.p.rapidapi.com";
  // Base headers for Response url
  static const Map<String, String> _headers = {
	    'x-rapidapi-key': "515b8b336amsh2436fb4f5ef076ep184143jsn8d433aaad72f",
      'x-rapidapi-host': "systran-systran-platform-for-language-processing-v1.p.rapidapi.com"
  };

  // Base API request to get response
  Future<dynamic> get({endpoint = "/translation/text/translate", required Map<String, String> query,}) async {
    var url = Uri.https(_baseUrl, endpoint, query);
    final response = await http.get(url, headers: _headers);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return json.decode(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load json data');
    }
  }

  Future<dynamic> getLang({endpoint = "/translation/supportedLanguages"}) async {
    Uri uri = Uri.https(_baseUrl, endpoint);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return json.decode(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load json data');
    }
  }
}