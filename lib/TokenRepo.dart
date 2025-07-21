import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TokenRepository {
  Future getLoginOdataToken() async {
    try {
      const url = 'https://login.microsoftonline.com/6957ebc5-df56-486d-b7bb-f99a6a804f93/oauth2/v2.0/token';
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      final data = {
        'grant_type': 'client_credentials',
        'client_id': '75ec9a62-0d5a-4544-a110-06cc344c8cb1', // Corrected key name
        'client_secret': 'VA~8Q~7athD9xU_M4dXDSa7dykIYFfHwmT_j7bF6', // Corrected key name
        'scope': 'https://api.businesscentral.dynamics.com/.default', // Corrected key name
      };

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: data.entries.map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&'),
      );

      if (response.statusCode == 200) {

        var data = json.decode(response.body);
        print(data);
        return data['access_token'];
      } else {
        debugPrint('Response status: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        return "failed";
      }
    } catch (e) {
      debugPrint('Error: $e');
      return "failed";
    }
  }
}
