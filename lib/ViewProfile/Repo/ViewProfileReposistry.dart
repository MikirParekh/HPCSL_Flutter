import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../ALL URL.dart';
import '../../TokenRepo.dart';
import '../Model/Viwed_Model.dart';

class ViewProfileApi {
  Future<ViwedModel> fetchViewProfile(String userId) async {
    try {
      final tokenRepo = TokenRepository();
      final bToken = await tokenRepo.getLoginOdataToken();


      final wpCustService = "${ApiConstants.baseUrl}/WP_P_Cust?\$filter=No eq '$userId'";

      final response = await http.get(
        Uri.parse(wpCustService),
        headers: {
          'Authorization': 'Bearer $bToken',
          'Prefer': 'odata.include-annotations="*"',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final viewModel = ViwedModel.fromJson(data);

        if (viewModel.value != null && viewModel.value!.isNotEmpty) {
          // Save user data in shared preferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('userid', data['value'][0]['No'] ?? '');
          await prefs.setBool('statusLogin', true);

          return viewModel;
        } else {
          throw Exception('No profile data found');
        }
      } else {
        throw Exception('Failed to fetch profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching profile: $e');
    }
  }
}

