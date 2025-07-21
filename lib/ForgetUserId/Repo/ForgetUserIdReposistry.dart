import 'package:flutter/cupertino.dart';
import 'package:hpcsl_1/ALL%20URL.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../TokenRepo.dart';

class ForgotUserIdRepository {

  Future<List<String>> forgotUserId(String input, {required bool isEmail}) async {
    final endpoint = isEmail
        ? 'Web_Development_Services_ForgotUserThroughEmail'
        : 'Web_Development_Services_ForgotUserThroughMobile';

    final url = Uri.parse('${ApiConstants.postbaseUrl}/$endpoint?Company=${ApiConstants.companyName}');
    debugPrint("FinalURL $url");

    final tokenRepo = TokenRepository();
    final bToken = await tokenRepo.getLoginOdataToken();
    debugPrint('Bearer Token: $bToken');

    final body = isEmail
        ? {'emailId': input}
        : {'custMobileNo': input};

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json','Authorization': 'Bearer $bToken',},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return ['success', 'User ID sent successfully'];
      } else {
        return ['error', 'Failed to process request: ${response.reasonPhrase}'];
      }
    } catch (e) {
      return ['error', 'Network error: ${e.toString()}'];
    }
  }
}