import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../ALL URL.dart';
import '../../SharedPreference.dart';
import '../../TokenRepo.dart';
import '../Model/Outstanding_Model.dart';
// Ensure the correct model is imported

class ViewOutstandingApi {
  // Existing method to fetch all states
  Future<OutstandingModel> fetchViewOutStanding(BuildContext context) async {

     var userid = await StorageManager.readData('userid');

    final tokenRepo = TokenRepository();
    final bToken = await tokenRepo.getLoginOdataToken();
    debugPrint('Bearer Token: $bToken');

    final headers = {
      'Authorization': 'Bearer $bToken',
      'Prefer': 'odata.include-annotations="*"',
    };

    var url = "${ApiConstants.baseUrl}/WP_P_CustomerSummary?\$filter=Customer_No eq \'$userid\'";

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final OutStandingList = OutstandingModel.fromJson(data);

        if (OutStandingList.value != null && OutStandingList.value!.isNotEmpty) {


          return OutStandingList;
        } else {
          throw Exception('No states found. Please try again later.');
        }
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
      rethrow; // Re-throw the exception to allow further handling if needed
    }
  }


}
