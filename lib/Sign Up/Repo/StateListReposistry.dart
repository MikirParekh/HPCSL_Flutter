import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hpcsl_1/ALL%20URL.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../TokenRepo.dart';
import '../Model/Postcode_model.dart';
import '../Model/State_model.dart'; // Ensure the correct model is imported

class StateApi {
  // Existing method to fetch user data
  Future<StateListModel> fetchStates(BuildContext context, String email, String password) async {
    TokenRepository tokenRepo = TokenRepository();
    var bToken = await tokenRepo.getLoginOdataToken();
    debugPrint(bToken);

    final headers = {
      'Authorization': 'Bearer $bToken',
      'Prefer': 'odata.include-annotations="*"',
    };

    StateListModel respData = StateListModel();
    try {
      // Replace with the actual URL
      http.Response response = await http.get(
        Uri.parse(
            "${ApiConstants.baseUrl}/States"
        ),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        respData = StateListModel.fromJson(data); // Use fromJson for Postcode

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
  Future<StateListModel> fetchStatesWithSearch(BuildContext context, String searchText) async {
    final tokenRepo = TokenRepository();
    final bToken = await tokenRepo.getLoginOdataToken();
    debugPrint('Bearer Token: $bToken');

    final headers = {
      'Authorization': 'Bearer $bToken',
      'Prefer': 'odata.include-annotations="*"',
    };

    // Updated URL to include the search term using $filter
    final searchQuery = Uri.encodeComponent(searchText);
    final url =
        '${ApiConstants.baseUrl}/States?\$filter=contains(Description,\'$searchQuery\')';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final stateList = StateListModel.fromJson(data);

        if (stateList.value != null && stateList.value!.isNotEmpty) {
          return stateList; // Return the filtered Postcode object
        } else {
          return StateListModel(value: []); // Return empty list if no postcodes are found
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
