import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hpcsl_1/ALL%20URL.dart';
import 'package:http/http.dart' as http;

import '../../TokenRepo.dart';

class ForgotMPINRepository {

  Future<void> handleSuccess(String identifier, bool isEmail) async {
    try {
      final tokenRepo = TokenRepository();
      final bToken = await tokenRepo.getLoginOdataToken();
      debugPrint('Bearer Token: $bToken');

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $bToken',
        'Prefer': 'odata.include-annotations="*"',
      };

      final endpoint = isEmail
          ? 'Web_Development_Services_ForgotMPINByEmail'
          : 'Web_Development_Services_ForgotMPINByMobile';

      // Properly construct and encode the URL
      final uri = Uri.parse('${ApiConstants.postbaseUrl}/$endpoint').replace(
        queryParameters: {
          'Company': ApiConstants.companyName
        },
      );

      final textLink = Uri.encodeComponent(
          "http://52.172.139.203:8090/Login/resetMPIN?id=$identifier");

      final body = isEmail
          ? {'emailId': identifier, 'text_Link': textLink}
          : {'mobileNo': identifier, 'text_Link': textLink};

      final request = http.Request('POST', uri);
      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        throw Exception('Failed to process request: ${response.statusCode}');
      }

      final responseData = jsonDecode(response.body);
      if (responseData == null) {
        throw Exception('Invalid response from server');
      }

      return responseData;
    } catch (e) {
      throw Exception('Error processing request: ${e.toString()}');
    }
  }

  Future<List<String>> forgotMPIN(String identifier, String textLink,
      {required bool isEmail}) async {
    try {
      await handleSuccess(identifier, isEmail);
      final successMessage = isEmail
          ? 'Reset link sent successfully to your email'
          : 'Reset link sent successfully to your mobile';
      return ['success', successMessage];
    } catch (e) {
      return ['error', e.toString()];
    }
  }
}
