// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:hpcsl_1/ALL%20URL.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../SharedPreference.dart';
// import '../../TokenRepo.dart';
// import '../Model/Empty_model.dart';
// import '../UI/Empty.dart';
//
//
// // Ensure the correct model is imported
//
// class EmptyTrackingApi {
//
//   Future<Map<String, String>> _getHeaders() async {
//     final tokenRepo = TokenRepository();
//     final bToken = await tokenRepo.getLoginOdataToken();
//     return {
//       'Authorization': 'Bearer $bToken',
//       'Prefer': 'odata.include-annotations="*"',
//     };
//   }
//
//
//   Future<EmptyTrackingModel> fetchFilteredEmptyTracking(BuildContext context, String userId) async {
//     try {
//       final headers = await _getHeaders();
//       List<dynamic> allResults = [];
//
//       // Make three separate requests with different filters
//       final filterQuery = "Do_Not_Show eq false"; // Fetch all records where Do_Not_Show is false
//       final encodedFilter = Uri.encodeComponent(filterQuery);
//
//       final url = "${ApiConstants.baseUrl}/WP_P_EmptyTrackingLineList?\$filter=$encodedFilter";
//
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['value'] != null) {
//           // Apply filtering in Dart
//           allResults.addAll(data['value'].where((item) =>
//           item['Shipping_Line_No'] == userId
//           ));
//         }
//       }
//         return EmptyTrackingModel.fromJson({'value': allResults});
//
//     } catch (e) {
//       _handleError(e);
//       return EmptyTrackingModel.fromJson({'value': []});
//     }
//   }
//
//
//
//   void _handleError(dynamic error) {
//   }
//
//   // New method to fetch states with a search term
//   Future<EmptyTrackingModel> fetchContainerNoWithSearch(BuildContext context, String searchText) async {
//     final tokenRepo = TokenRepository();
//     final bToken = await tokenRepo.getLoginOdataToken();
//     debugPrint('Bearer Token: $bToken');
//
//     final headers = {
//       'Authorization': 'Bearer $bToken',
//       'Prefer': 'odata.include-annotations="*"',
//     };
//
//     // Updated URL to include the search term using $filter
//     final url =
//         '${ApiConstants.baseUrl}/WP_P_EmptyTrackingLineList?\$filter=contains(Container_No,\'$searchText\')';
//
//     debugPrint('URL: $url');
//
//     try {
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200)
//       {
//         final data = jsonDecode(response.body);
//         final EmptyList = EmptyTrackingModel.fromJson(data);
//
//         debugPrint('data: $data');
//         if (EmptyList.value != null && EmptyList.value!.isNotEmpty) {
//           return EmptyList; // Return the filtered StateListModel object
//         } else {
//           throw Exception('');
//         }
//       } else {
//         throw Exception('Failed with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       rethrow; // Re-throw the exception for further handling if needed
//     }
//   }
//
//   // New method to fetch states with a search term
//   Future<EmptyTrackingModel> fetchDonoWithSearch(BuildContext context, String searchText) async {
//     final tokenRepo = TokenRepository();
//     final bToken = await tokenRepo.getLoginOdataToken();
//     debugPrint('Bearer Token: $bToken');
//
//     final headers = {
//       'Authorization': 'Bearer $bToken',
//       'Prefer': 'odata.include-annotations="*"',
//     };
//
//     // Updated URL to include the search term using $filter
//     final url =
//         '${ApiConstants.baseUrl}/WP_P_EmptyTrackingLineList?\$filter=contains(DO_No,\'$searchText\')';
//
//     debugPrint('URL: $url');
//
//     try {
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200)
//       {
//         final data = jsonDecode(response.body);
//         final EmptyList = EmptyTrackingModel.fromJson(data);
//
//         debugPrint('data: $data');
//         if (EmptyList.value != null && EmptyList.value!.isNotEmpty) {
//           return EmptyList; // Return the filtered StateListModel object
//         } else {
//           throw Exception('');
//         }
//       } else {
//         throw Exception('Failed with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       rethrow; // Re-throw the exception for further handling if needed
//     }
//   }
// }

// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import '../../ALL URL.dart';
// import '../../SharedPreference.dart';
// import '../../TokenRepo.dart';
// import 'package:http/http.dart' as http;
//
// import '../Model/Empty_model.dart';
//
//
// class EmptyTrackingApi {
//   Future<Map<String, String>> _getHeaders() async {
//     final tokenRepo = TokenRepository();
//     final bToken = await tokenRepo.getLoginOdataToken();
//     return {
//       'Authorization': 'Bearer $bToken',
//       'Prefer': 'odata.include-annotations="*"',
//     };
//   }
//
//   Future<List<EmptyTrackingModel1>> _fetchEmptyTrackingDataByField(String fieldName) async {
//     try {
//       final userid = await StorageManager.readData('userid');
//       final headers = await _getHeaders();
//       final encodedFilter = Uri.encodeComponent(
//           "$fieldName eq '$userid' and Do_Not_Show eq false");
//       final url = "${ApiConstants.baseUrl}/WP_P_EmptyTrackingLineList?"
//           "\$filter=$encodedFilter";
//
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final List<dynamic> items = data['value'];
//         return items.map((item) => EmptyTrackingModel1.fromJson(item)).toList();
//       }
//       return [];
//     } catch (e) {
//       debugPrint('Error in _fetchImportDataByField: $e');
//       return [];
//     }
//   }
//
//
//   Future<List<EmptyTrackingModel1>> fetchTransportDataShippingLineNo() async {
//     return _fetchEmptyTrackingDataByField('Shipping_Line_No');
//   }
//
//
//   Future<List<EmptyTrackingModel1>> listOfTransportData({
//     String? containerNoSearch,
//     String? blNoSearch,
//   }) async {
//     try {
//       // If search parameters are provided, use the search endpoints
//       if (containerNoSearch != null && containerNoSearch.isNotEmpty) {
//         final result = await fetchContainerNo(containerNoSearch);
//         return result.value ?? [];
//       }
//
//       if (blNoSearch != null && blNoSearch.isNotEmpty) {
//         final result = await fetchDoNo(blNoSearch);
//         return result.value ?? [];
//       }
//
//       // Otherwise, fetch all data as before
//       final results = await Future.wait([
//         fetchTransportDataShippingLineNo(),
//       ]);
//
//       return results.expand((list) => list).toList();
//     } catch (e) {
//       debugPrint('Error in listOfEmptyData: $e');
//       return [];
//     }
//   }
//
//   Future<EmptyTrackingModel> fetchContainerNo(String searchText) async {
//     return _fetchEmptyDataBySearch('Container_No', searchText);
//   }
//
//   Future<EmptyTrackingModel> fetchDoNo(String searchText) async {
//     return _fetchEmptyDataBySearch('DO_No', searchText);
//   }
//
//   Future<EmptyTrackingModel> _fetchEmptyDataBySearch(String field, String searchText) async {
//     try {
//       final userid = await StorageManager.readData('userid');
//       final headers = await _getHeaders();
//       final encodedFilter = Uri.encodeComponent(
//           "contains($field,'$searchText') and UserId eq '$userid'");
//       final url = '${ApiConstants.baseUrl}/WP_P_EmptyTrackingLineList?'
//           '\$filter=$encodedFilter';
//
//       debugPrint('API URL: $url'); // For debugging
//
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final importList = EmptyTrackingModel.fromJson(data);
//         return importList; // Return even if empty
//       }
//       throw Exception('Failed with status code: ${response.statusCode}');
//     } catch (e) {
//       debugPrint('Error in _fetchEmptyDataBySearch: $e');
//       rethrow;
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../ALL URL.dart';
import '../../SharedPreference.dart';
import '../../TokenRepo.dart';
import 'package:http/http.dart' as http;
import '../Model/Empty_model.dart';

class EmptyTrackingApi {
  Future<Map<String, String>> _getHeaders() async {
    final tokenRepo = TokenRepository();
    final bToken = await tokenRepo.getLoginOdataToken();
    return {
      'Authorization': 'Bearer $bToken',
      'Prefer': 'odata.include-annotations="*"',
    };
  }

  Future<List<EmptyTrackingModel1>> _fetchEmptyTrackingDataByField(String fieldName, String userId) async {
    try {
      final headers = await _getHeaders();
      final encodedFilter = Uri.encodeComponent(
          "$fieldName eq '$userId' and Do_Not_Show eq false");
      final url = "${ApiConstants.baseUrl}/WP_P_EmptyTrackingLineList?"
          "\$filter=$encodedFilter";

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> items = data['value'];
        return items.map((item) => EmptyTrackingModel1.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error in _fetchEmptyTrackingDataByField: $e');
      return [];
    }
  }

  Future<List<EmptyTrackingModel1>> fetchTransportDataShippingLineNo() async {
    final userId = await StorageManager.readData('userid');
    return _fetchEmptyTrackingDataByField('Shipping_Line_No', userId);
  }

  Future<List<EmptyTrackingModel1>> listOfTransportData({
    String? containerNoSearch,
    String? blNoSearch,
  }) async {
    try {
      final userId = await StorageManager.readData('userid');

      if (containerNoSearch != null && containerNoSearch.isNotEmpty) {
        return await _fetchEmptyDataBySearch('Container_No', containerNoSearch, userId);
      }

      if (blNoSearch != null && blNoSearch.isNotEmpty) {
        return await _fetchEmptyDataBySearch('DO_No', blNoSearch, userId);
      }

      // Otherwise, fetch all data as before
      final results = await Future.wait([
        fetchTransportDataShippingLineNo(),
      ]);

      return results.expand((list) => list).toList();
    } catch (e) {
      debugPrint('Error in listOfTransportData: $e');
      return [];
    }
  }

  Future<List<EmptyTrackingModel1>> fetchContainerNo(String searchText) async {
    final userId = await StorageManager.readData('userid');
    return _fetchEmptyDataBySearch('Container_No', searchText, userId);
  }

  Future<List<EmptyTrackingModel1>> fetchDoNo(String searchText) async {
    final userId = await StorageManager.readData('userid');
    return _fetchEmptyDataBySearch('DO_No', searchText, userId);
  }

  Future<List<EmptyTrackingModel1>> _fetchEmptyDataBySearch(
      String field,
      String searchText,
      String userId,
      ) async {
    try {
      final headers = await _getHeaders();
      final List<EmptyTrackingModel1> results = [];

      // Check each field separately with the Do_Not_Show condition
      final fieldsToCheck = [
        'Shipping_Line_No', // Add other fields if needed
      ];

      for (var userField in fieldsToCheck) {
        final encodedFilter = Uri.encodeComponent(
            "contains($field,'$searchText') and Do_Not_Show eq false and $userField eq '$userId'"
        );

        final url = '${ApiConstants.baseUrl}/WP_P_EmptyTrackingLineList?'
            '\$filter=$encodedFilter';

        debugPrint('API URL: $url');

        final response = await http.get(Uri.parse(url), headers: headers);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final List<dynamic> items = data['value'];
          results.addAll(items.map((item) => EmptyTrackingModel1.fromJson(item)).toList());
        }
      }

      // Remove duplicates if any
      final uniqueResults = results.toSet().toList();
      return uniqueResults;
    } catch (e) {
      debugPrint('Error in _fetchEmptyDataBySearch: $e');
      rethrow;
    }
  }
}