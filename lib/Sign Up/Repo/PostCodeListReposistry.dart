import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hpcsl_1/ALL%20URL.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../TokenRepo.dart';
import '../Model/Postcode_model.dart'; // Ensure the correct model is imported

class UserApi {
  // Existing method to fetch user data
  Future<Postcode> fetchUser(BuildContext context, String email, String password) async {
    TokenRepository tokenRepo = TokenRepository();
    var bToken = await tokenRepo.getLoginOdataToken();
    debugPrint(bToken);

    final headers = {
      'Authorization': 'Bearer $bToken',
      'Prefer': 'odata.include-annotations="*"',
    };

    Postcode respData = Postcode();
    try {
      // Replace with the actual URL
      http.Response response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/WP_P_PostCode'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        respData = Postcode.fromJson(data); // Use fromJson for Postcode

        if (respData.value != null && respData.value!.isNotEmpty) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userid', data['value'][0]['No'] ?? '');
          prefs.setBool('statusLogin', true);

          return respData; // Return Postcode object
        } else {
          throw 'Please check your credentials...';
        }
      } else {
        throw 'Login failed with status code: ${response.statusCode}';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(' ${e.toString()}')),
      );
      rethrow; // Rethrow exception after logging it
    }
  }

  // New method to fetch postcodes with a search term
  Future<Postcode> fetchPostCodeWithSearch(BuildContext context, String searchText) async {
    final tokenRepo = TokenRepository();
    final bToken = await tokenRepo.getLoginOdataToken();
    debugPrint('Bearer Token: $bToken');

    final headers = {
      'Authorization': 'Bearer $bToken',
      'Prefer': 'odata.include-annotations="*"',
    };

    // Updated URL to include the search term using $filter
    final url =
        '${ApiConstants.baseUrl}/WP_P_PostCode?\$filter=contains(Code,\'$searchText\')';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final postcodeList = Postcode.fromJson(data);

        if (postcodeList.value != null && postcodeList.value!.isNotEmpty) {
          return postcodeList; // Return the filtered Postcode object
        } else {
          return Postcode(value: []); // Return empty list if no postcodes are found
        }
      } else {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Simply rethrow the error without showing a SnackBar
      rethrow; // Re-throw the exception for further handling if needed
    }
  }

}
