// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../../ALL URL.dart';
// import '../../TokenRepo.dart';
// import '../Model/Export_Model.dart';
//
// class ExportApi {
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
//   Future<ExportModel> fetchFilteredExportData(BuildContext context, String userId) async {
//     try {
//       print("Fetching Export Data for userId: $userId");
//
//       final headers = await _getHeaders();
//       print("Headers: $headers");
//
//       List<dynamic> allResults = [];
//
//       final filterQuery = "Do_Not_Show eq false";
//       final encodedFilter = Uri.encodeComponent(filterQuery);
//
//       final url = "${ApiConstants.baseUrl}/WP_P_ExportTrackingLineList?\$filter=$encodedFilter";
//
//       print("Making request to URL: $url");
//
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       print("Response Status Code: ${response.statusCode}");
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//        print("Total items recieved from API:${data['value'].length}");
//
//         if (data['value'] != null) {
//           final filteredItems = data['value'].where((item) {
//             final match = item['Exporter_No'] == userId ||
//                 item['CHA_No'] == userId ||
//                 item['Shipping_Line_No'] == userId;
//             if (match) {
//             }
//             return match;
//           }).toList();
//
//           allResults.addAll(filteredItems);
//         } else {
//           print("No 'value' key found in response!");
//         }
//       } else {
//         print("Error: Status Code ${response.statusCode}");
//       }
//
//       print("Filtered Results Count: ${allResults.length}");
//
//       return ExportModel.fromJson({'value': allResults});
//
//     } catch (e) {
//       print("Error Occurred: $e");
//       _handleError(e);
//       return ExportModel.fromJson({'value': []});
//     }
//   }
//
//   void _handleError(dynamic error) {
//     print("Handled Error: $error");
//   }
//
//
//   //New method to fetch states with a search term
//   Future<ExportModel> fetchContainerNoWithSearch(BuildContext context, String searchText) async {
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
//         '${ApiConstants.baseUrl}/WP_P_ExportTrackingLineList?\$filter=contains(Container_No,\'$searchText\')';
//
//     debugPrint('URL: $url');
//
//     try {
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200)
//       {
//         final data = jsonDecode(response.body);
//         final ExportList = ExportModel.fromJson(data);
//
//         debugPrint('data: $data');
//         if (ExportList.value != null && ExportList.value!.isNotEmpty) {
//           return ExportList; // Return the filtered StateListModel object
//         } else {
//           throw Exception('');
//         }
//       } else {
//         throw Exception('Failed with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//
//       rethrow; // Re-throw the exception for further handling if needed
//     }
//   }
//
//   // New method to fetch states with a search term
//   Future<ExportModel> fetchShippingBillWithSearch(BuildContext context, String searchText) async {
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
//         '${ApiConstants.baseUrl}/WP_P_ExportTrackingLineList?\$filter=contains(Shipping_Bill_No,\'$searchText\')';
//
//     debugPrint('URL: $url');
//
//     try {
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200)
//       {
//         final data = jsonDecode(response.body);
//         final ExportList = ExportModel.fromJson(data);
//
//         debugPrint('data: $data');
//         if (ExportList.value != null && ExportList.value!.isNotEmpty) {
//           return ExportList; // Return the filtered StateListModel object
//         } else {
//           throw Exception('');
//         }
//       } else {
//         throw Exception('Failed with status code: ${response.statusCode}');
//       }
//     } catch (e) {
//
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
// import '../Model/Export_Model.dart';
//
// class ExportApi {
//   Future<Map<String, String>> _getHeaders() async {
//     final tokenRepo = TokenRepository();
//     final bToken = await tokenRepo.getLoginOdataToken();
//     return {
//       'Authorization': 'Bearer $bToken',
//       'Prefer': 'odata.include-annotations="*"',
//     };
//   }
//
//   Future<List<ExportModel1>> _fetchExportDataByField(String fieldName) async {
//     try {
//       final userid = await StorageManager.readData('userid');
//       final headers = await _getHeaders();
//       final encodedFilter = Uri.encodeComponent(
//           "$fieldName eq '$userid' and Do_Not_Show eq false");
//       final url = "${ApiConstants.baseUrl}/WP_P_ExportTrackingLineList?"
//           "\$filter=$encodedFilter";
//
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final List<dynamic> items = data['value'];
//         return items.map((item) => ExportModel1.fromJson(item)).toList();
//       }
//       return [];
//     } catch (e) {
//       debugPrint('Error in _fetchExportDataByField: $e');
//       return [];
//     }
//   }
//
//   Future<List<ExportModel1>> fetchExportDataExportNo() async {
//     return _fetchExportDataByField('Exporter_No');
//   }
//
//   Future<List<ExportModel1>> fetchExportDataChaNo() async {
//     return _fetchExportDataByField('CHA_No');
//   }
//
//   Future<List<ExportModel1>> fetchExportShipping() async {
//     return _fetchExportDataByField('Shipping_Line_No');
//   }
//
//
//   Future<List<ExportModel1>> listOfExportData({
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
//         final result = await fetchShippingBillNo(blNoSearch);
//         return result.value ?? [];
//       }
//
//       // Otherwise, fetch all data as before
//       final results = await Future.wait([
//         fetchExportDataExportNo(),
//         fetchExportDataChaNo(),
//         fetchExportShipping(),
//       ]);
//
//       return results.expand((list) => list).toList();
//     } catch (e) {
//       debugPrint('Error in listOfExportData: $e');
//       return [];
//     }
//   }
//
//   Future<ExportModel> fetchContainerNo(String searchText) async {
//     return _fetchExportDataBySearch('Container_No', searchText);
//   }
//
//   Future<ExportModel> fetchShippingBillNo(String searchText) async {
//     return _fetchExportDataBySearch('Shipping_Bill_No', searchText);
//   }
//
//   Future<ExportModel> _fetchExportDataBySearch(String field, String searchText) async {
//     try {
//       final userid = await StorageManager.readData('userid');
//       final headers = await _getHeaders();
//       final encodedFilter = Uri.encodeComponent(
//           "contains($field,'$searchText') and UserId eq '$userid'");
//       final url = '${ApiConstants.baseUrl}/WP_P_ExportTrackingLineList?'
//           '\$filter=$encodedFilter';
//
//       debugPrint('API URL: $url'); // For debugging
//
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final importList = ExportModel.fromJson(data);
//         return importList; // Return even if empty
//       }
//       throw Exception('Failed with status code: ${response.statusCode}');
//     } catch (e) {
//       debugPrint('Error in _fetchExportDataBySearch: $e');
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
import '../Model/Export_Model.dart';

class ExportApi {
  Future<Map<String, String>> _getHeaders() async {
    final tokenRepo = TokenRepository();
    final bToken = await tokenRepo.getLoginOdataToken();
    return {
      'Authorization': 'Bearer $bToken',
      'Prefer': 'odata.include-annotations="*"',
    };
  }

  Future<List<ExportModel1>> _fetchExportDataByField(String fieldName, String userId) async {
    try {
      final headers = await _getHeaders();
      final encodedFilter = Uri.encodeComponent(
          "$fieldName eq '$userId' and Do_Not_Show eq false");
      final url = "${ApiConstants.baseUrl}/WP_P_ExportTrackingLineList?"
          "\$filter=$encodedFilter";

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> items = data['value'];
        return items.map((item) => ExportModel1.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error in _fetchExportDataByField: $e');
      return [];
    }
  }

  Future<List<ExportModel1>> fetchExportDataExportNo() async {
    final userId = await StorageManager.readData('userid');
    return _fetchExportDataByField('Exporter_No', userId);
  }

  Future<List<ExportModel1>> fetchExportDataChaNo() async {
    final userId = await StorageManager.readData('userid');
    return _fetchExportDataByField('CHA_No', userId);
  }

  Future<List<ExportModel1>> fetchExportShipping() async {
    final userId = await StorageManager.readData('userid');
    return _fetchExportDataByField('Shipping_Line_No', userId);
  }

  Future<List<ExportModel1>> listOfExportData({
    String? containerNoSearch,
    String? blNoSearch,
  }) async {
    try {
      final userId = await StorageManager.readData('userid');

      if (containerNoSearch != null && containerNoSearch.isNotEmpty) {
        return await _fetchExportDataBySearch('Container_No', containerNoSearch, userId);
      }

      if (blNoSearch != null && blNoSearch.isNotEmpty) {
        return await _fetchExportDataBySearch('Shipping_Bill_No', blNoSearch, userId);
      }

      // Otherwise, fetch all data as before
      final results = await Future.wait([
        fetchExportDataExportNo(),
        fetchExportDataChaNo(),
        fetchExportShipping(),
      ]);

      return results.expand((list) => list).toList();
    } catch (e) {
      debugPrint('Error in listOfExportData: $e');
      return [];
    }
  }

  Future<List<ExportModel1>> fetchContainerNo(String searchText) async {
    final userId = await StorageManager.readData('userid');
    return _fetchExportDataBySearch('Container_No', searchText, userId);
  }

  Future<List<ExportModel1>> fetchShippingBillNo(String searchText) async {
    final userId = await StorageManager.readData('userid');
    return _fetchExportDataBySearch('Shipping_Bill_No', searchText, userId);
  }

  Future<List<ExportModel1>> _fetchExportDataBySearch(
      String field,
      String searchText,
      String userId,
      ) async {
    try {
      final headers = await _getHeaders();
      final List<ExportModel1> results = [];

      // Check each field separately with the Do_Not_Show condition
      final fieldsToCheck = [
        'Exporter_No',
        'CHA_No',
        'Shipping_Line_No'
      ];

      for (var userField in fieldsToCheck) {
        final encodedFilter = Uri.encodeComponent(
            "contains($field,'$searchText') and Do_Not_Show eq false and $userField eq '$userId'"
        );

        final url = '${ApiConstants.baseUrl}/WP_P_ExportTrackingLineList?'
            '\$filter=$encodedFilter';

        debugPrint('API URL: $url');

        final response = await http.get(Uri.parse(url), headers: headers);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final List<dynamic> items = data['value'];
          results.addAll(items.map((item) => ExportModel1.fromJson(item)).toList());
        }
      }

      // Remove duplicates if any
      final uniqueResults = results.toSet().toList();
      return uniqueResults;
    } catch (e) {
      debugPrint('Error in _fetchExportDataBySearch: $e');
      rethrow;
    }
  }
}