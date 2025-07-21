import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hpcsl_1/ALL%20URL.dart';
import 'package:http/http.dart' as http;
import '../../SharedPreference.dart';
import '../../TokenRepo.dart';

class ChangePasswordApi {
  Future<int> updateLoginData(String no, String password, String mpin, String token) async {
    var userid = await StorageManager.readData('userid');
    int res = 1;

    try {
      // Base URLs
      final wpCustService = "${ApiConstants.baseUrl}/WP_P_Cust?\$filter=No eq '$userid'";
      final custPassword = "${ApiConstants.baseUrl}/CustPassword(No='$userid')";

      final tokenRepo = TokenRepository();
      final bToken = (await tokenRepo.getLoginOdataToken()).trim();

      // First request to verify customer exists
      var response = await http.get(
        Uri.parse(wpCustService),
        headers: {
          'Authorization': 'Bearer $bToken',
          'Prefer': 'odata.include-annotations="*"',
        },
      );

      if (response.statusCode == 200) {
        var customerData = json.decode(response.body);

        if (customerData["value"].isNotEmpty) {
          // Prepare update data
          Map<String, dynamic> updateData = {
            "Password": password,
            "MPIN": mpin
          };

          // Update password/MPIN request
          var updateResponse = await http.patch(
            Uri.parse(custPassword),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $bToken',
              'If-Match': '*'
            },
            body: json.encode(updateData),
          );

          if (updateResponse.statusCode == 200 || updateResponse.statusCode == 204) {
            debugPrint('Password/MPIN updated successfully');
            res = 0;
          } else {
            debugPrint('Update failed: ${updateResponse.statusCode} - ${updateResponse.body}');
            res = 1;
          }
        } else {
          debugPrint('No customer found with ID: $userid');
          res = 2;
        }
      } else {
        debugPrint('Failed to fetch customer: ${response.statusCode} - ${response.body}');
        res = 1;
      }
    } catch (e) {
      debugPrint('Exception during password update: $e');
      res = 1;
    }
    return res;
  }
}