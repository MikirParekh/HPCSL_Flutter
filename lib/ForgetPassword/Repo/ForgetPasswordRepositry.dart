// repositories/forgot_password_repository.dart
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hpcsl_1/ALL%20URL.dart';
import 'package:http/http.dart' as http;
import '../../TokenRepo.dart';

class ForgotPasswordRepository {

  Future<List<String>> forgotPASSWORD(String input, String textLink, {required bool isEmail}) async {
    try {

      final endpoint = isEmail
          ? 'Web_Development_Services_ForgotPasswordByEmail'
          : 'Web_Development_Services_ForgotPasswordByMoble';

      final Uri uri = Uri.parse('${ApiConstants.postbaseUrl}/$endpoint?Company=${ApiConstants.companyName}');
      debugPrint('Final Url $uri');


      final tokenRepo = TokenRepository();
      final bToken = await tokenRepo.getLoginOdataToken();
      debugPrint('Bearer Token: $bToken');
      debugPrint('Bearer Token Length: ${bToken.length}');

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': '$bToken',
      };


      final Map<String, String> body = isEmail
          ? {
        'emailID': input,
        'text_Link': textLink,
      }
          : {
        'mobileNo': input,
        'text_Link': textLink,
      };

      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return ['success', 'Password reset link has been sent successfully'];
      } else {
        return ['error', 'Failed to process request: ${response.reasonPhrase}'];
      }
    } catch (e) {
      return ['error', 'An error occurred: $e'];
    }
  }
}