// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:hpcsl_1/ALL%20URL.dart';
// import 'package:hpcsl_1/Transport/UI/Transport.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../SharedPreference.dart';
// import '../../TokenRepo.dart';
// import '../Model/Transport_Model.dart';
//
// // Ensure the correct model is imported
//
// class TransportApi {
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
//   Future<TransportModel> fetchTransportData(BuildContext context, String userId) async {
//     try {
//       final headers = await _getHeaders();
//       List<dynamic> allResults = [];
//
//       // Make three separate requests with different filters
//       final filterQuery = "Do_Not_Show eq false"; // Fetch all records where Do_Not_Show is false
//       final encodedFilter = Uri.encodeComponent(filterQuery);
//
//       final url = "${ApiConstants.baseUrl}/WP_P_TransportTrackingLineList?\$filter=$encodedFilter";
//
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['value'] != null) {
//           // Apply filtering in Dart
//           allResults.addAll(data['value'].where((item) =>
//           item['Exporter_No'] == userId ||
//               item['CHA_No'] == userId ||
//               item['Shipping_Line_No'] == userId ||
//               item['Importer_No'] == userId ||
//               item['Consignor'] == userId ||
//               item['Consignee'] == userId
//           ));
//         }
//       }
//
//         return TransportModel.fromJson({'value': allResults});
//
//       throw const TransportException('No matching exports found.');
//     } catch (e) {
//       _handleError(e);
//       return TransportModel.fromJson({'value': []});
//     }
//   }
//
//   void _handleError( dynamic error) {
//   }
//
//   // Future<TransportModel> fetchTransportData(BuildContext context, String userId) async {
//   //   try {
//   //     final headers = await _getHeaders();
//   //     const commonFilters = "Do_Not_Show eq false and Closed eq false and Cancelled eq false";
//   //
//   //     // Fields to check
//   //     final filterFields = [
//   //       'Exporter_No',
//   //       'CHA_No',
//   //       'Shipping_Line_No',
//   //       'Importer_No',
//   //       'Consignor',
//   //       'Consignee',
//   //     ];
//   //
//   //     String? matchedField;
//   //
//   //     // Check which field matches using an initial request (or by logic if known)
//   //     final checkUrl = "${ApiConstants.baseUrl}/WP_P_TransportTrackingLineList?\$filter=Do_Not_Show eq false";
//   //     final response = await http.get(Uri.parse(checkUrl), headers: headers);
//   //
//   //     if (response.statusCode == 200) {
//   //       final data = jsonDecode(response.body);
//   //
//   //       final totalCount=(data['value'] as List).length;
//   //       debugPrint('Total number of data items:$totalCount');
//   //
//   //       if (data['value'] != null) {
//   //         final items = data['value'] as List;
//   //         for (var field in filterFields) {
//   //           if (items.any((item) => item[field] == userId)) {
//   //             matchedField = field;
//   //             break;
//   //           }
//   //         }
//   //       }
//   //     }
//   //
//   //     if (matchedField == null) {
//   //       throw const TransportException(
//   //           "No matching data found for this user ID.");
//   //     }
//   //
//   //     final dynamicFilter = "$commonFilters and $matchedField eq '$userId'";
//   //     final encodedFilter = Uri.encodeComponent(dynamicFilter);
//   //
//   //     final finalUrl = "${ApiConstants.baseUrl}/WP_P_TransportTrackingLineList?\$filter=$encodedFilter";
//   //
//   //     final filteredResponse = await http.get(
//   //         Uri.parse(finalUrl), headers: headers);
//   //
//   //     if (filteredResponse.statusCode == 200) {
//   //       final data = jsonDecode(filteredResponse.body);
//   //       return TransportModel.fromJson({'value': data['value']});
//   //     }
//   //
//   //     throw const TransportException("Data fetch failed.");
//   //   } catch (e) {
//   //     _handleError(e);
//   //     return TransportModel.fromJson({'value': []});
//   //   }
//   // }
//   //
//   // void _handleError(dynamic error) {
//   //    }
//
//
//     // New method to fetch states with a search term
//     Future<TransportModel> fetchContainerNoWithSearch(BuildContext context,
//         String searchText) async {
//       final tokenRepo = TokenRepository();
//       final bToken = await tokenRepo.getLoginOdataToken();
//       debugPrint('Bearer Token: $bToken');
//
//       final headers = {
//         'Authorization': 'Bearer $bToken',
//         'Prefer': 'odata.include-annotations="*"',
//       };
//
//       // Updated URL to include the search term using $filter
//       final url =
//           '${ApiConstants
//           .baseUrl}/WP_P_TransportTrackingLineList?\$filter=contains(Container_No,\'$searchText\')';
//
//       debugPrint('URL: $url');
//
//       try {
//         final response = await http.get(Uri.parse(url), headers: headers);
//
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           final ExportList = TransportModel.fromJson(data);
//
//           debugPrint('data: $data');
//           if (ExportList.value != null && ExportList.value!.isNotEmpty) {
//             return ExportList; // Return the filtered StateListModel object
//           } else {
//             throw Exception('No Transport found matching your search.');
//           }
//         } else {
//           throw Exception('Failed with status code: ${response.statusCode}');
//         }
//       } catch (e) {
//         rethrow; // Re-throw the exception for further handling if needed
//       }
//     }
//
//     // New method to fetch states with a search term
//     Future<TransportModel> fetchGRNoWithSearch(BuildContext context,
//         String searchText) async {
//       final tokenRepo = TokenRepository();
//       final bToken = await tokenRepo.getLoginOdataToken();
//       debugPrint('Bearer Token: $bToken');
//
//       final headers = {
//         'Authorization': 'Bearer $bToken',
//         'Prefer': 'odata.include-annotations="*"',
//       };
//
//       // Updated URL to include the search term using $filter
//       final url =
//           '${ApiConstants
//           .baseUrl}/WP_P_TransportTrackingLineList?\$filter=contains(GR_No,\'$searchText\')';
//
//       debugPrint('URL: $url');
//
//       try {
//         final response = await http.get(Uri.parse(url), headers: headers);
//
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           final ExportList = TransportModel.fromJson(data);
//
//           debugPrint('data: $data');
//           if (ExportList.value != null && ExportList.value!.isNotEmpty) {
//             return ExportList; // Return the filtered StateListModel object
//           } else {
//             throw Exception('No Export found matching your search.');
//           }
//         } else {
//           throw Exception('Failed with status code: ${response.statusCode}');
//         }
//       } catch (e) {
//         rethrow; // Re-throw the exception for further handling if needed
//       }
//     }
//   }

// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import '../../ALL URL.dart';
// import '../../SharedPreference.dart';
// import '../../TokenRepo.dart';
// import 'package:http/http.dart' as http;
// import '../Model/Transport_Model.dart';
//
// class TransportApi {
//   Future<Map<String, String>> _getHeaders() async {
//     final tokenRepo = TokenRepository();
//     final bToken = await tokenRepo.getLoginOdataToken();
//     return {
//       'Authorization': 'Bearer $bToken',
//       'Prefer': 'odata.include-annotations="*"',
//     };
//   }
//
//   Future<List<TransportModel1>> _fetchTransportDataByField(String fieldName) async {
//     try {
//       final userid = await StorageManager.readData('userid');
//       final headers = await _getHeaders();
//       final encodedFilter = Uri.encodeComponent(
//           "$fieldName eq '$userid' and Do_Not_Show eq false");
//       final url = "${ApiConstants.baseUrl}/WP_P_TransportTrackingLineList?"
//           "\$filter=$encodedFilter";
//
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final List<dynamic> items = data['value'];
//         return items.map((item) => TransportModel1.fromJson(item)).toList();
//       }
//       return [];
//     } catch (e) {
//       debugPrint('Error in _fetchTransportDataByField: $e');
//       return [];
//     }
//   }
//
//   Future<List<TransportModel1>> fetchExporterNo() async {
//     return _fetchTransportDataByField('Exporter_No');
//   }
//
//   Future<List<TransportModel1>> fetchChaNo() async {
//     return _fetchTransportDataByField('CHA_No');
//   }
//
//   Future<List<TransportModel1>> fetchShippingLineNo() async {
//     return _fetchTransportDataByField('Shipping_Line_No');
//   }
//
//   Future<List<TransportModel1>> fetchImportNO() async {
//     return _fetchTransportDataByField('Importer_No');
//   }
//   Future<List<TransportModel1>> fetchConsignor() async {
//     return _fetchTransportDataByField('Consignor');
//   }
//   Future<List<TransportModel1>> fetchConsignee() async {
//     return _fetchTransportDataByField('Consignee');
//   }
//
//   Future<List<TransportModel1>> listOfTransportData({
//     String? containerNoSearch,
//     String? grnoSearch,
//   }) async {
//     try {
//       // If search parameters are provided, use the search endpoints
//       if (containerNoSearch != null && containerNoSearch.isNotEmpty) {
//         final result = await fetchContainerNo(containerNoSearch);
//         return result.value ?? [];
//       }
//
//       if (grnoSearch != null && grnoSearch.isNotEmpty) {
//         final result = await fetchGrNo(grnoSearch);
//         return result.value ?? [];
//       }
//
//       // Otherwise, fetch all data as before
//       final results = await Future.wait([
//         fetchExporterNo(),
//         fetchChaNo(),
//         fetchShippingLineNo(),
//         fetchImportNO(),
//         fetchConsignor(),
//         fetchConsignee()
//       ]);
//
//       return results.expand((list) => list).toList();
//     } catch (e) {
//       debugPrint('Error in listOfTransportData: $e');
//       return [];
//     }
//   }
//
//   Future<TransportModel> fetchContainerNo(String searchText) async {
//     return _fetchTransportDataBySearch('Container_No', searchText);
//   }
//
//   Future<TransportModel> fetchGrNo(String searchText) async {
//     return _fetchTransportDataBySearch('GR_No', searchText);
//   }
//
//   Future<TransportModel> _fetchTransportDataBySearch(String field, String searchText) async {
//     try {
//       final userid = await StorageManager.readData('userid');
//       final headers = await _getHeaders();
//       final encodedFilter = Uri.encodeComponent(
//           "contains($field,'$searchText') and UserId eq '$userid'");
//       final url = '${ApiConstants.baseUrl}/WP_P_TransportTrackingLineList?'
//           '\$filter=$encodedFilter';
//
//       debugPrint('API URL: $url'); // For debugging
//
//       final response = await http.get(Uri.parse(url), headers: headers);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final importList = TransportModel.fromJson(data);
//         return importList; // Return even if empty
//       }
//       throw Exception('Failed with status code: ${response.statusCode}');
//     } catch (e) {
//       debugPrint('Error in _fetchTransportDataBySearch: $e');
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
import '../Model/Transport_Model.dart';

class TransportApi {
  static const List<String> _userFields = [
    'Exporter_No',
    'CHA_No',
    'Shipping_Line_No',
    'Importer_No',
    'Consignor',
    'Consignee'
  ];

  Future<Map<String, String>> _getHeaders() async {
    final tokenRepo = TokenRepository();
    final bToken = await tokenRepo.getLoginOdataToken();
    return {
      'Authorization': 'Bearer $bToken',
      'Prefer': 'odata.include-annotations="*"',
    };
  }

  Future<List<TransportModel1>> _fetchTransportDataByField(
      String fieldName, String userId) async {
    try {
      final headers = await _getHeaders();
      final encodedFilter = Uri.encodeComponent(
          "$fieldName eq '$userId' and Do_Not_Show eq false and Cancelled eq false");
      final url = "${ApiConstants.baseUrl}/WP_P_TransportTrackingLineList?"
          "\$filter=$encodedFilter";
      debugPrint("Transport Page API URL: $url");
      debugPrint("Decoded Filter: $fieldName eq '$userId' and Do_Not_Show eq false and Closed eq false and Cancelled eq false and GR_No ne '' ");


      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> items = data['value'];
        return items.map((item) => TransportModel1.fromJson(item)).toList();
      }
      throw Exception('Failed to load data with status: ${response.statusCode}');
    } catch (e) {
      debugPrint('Error in _fetchTransportDataByField: $e');
      rethrow;
    }
  }

  Future<List<TransportModel1>> _fetchTransportDataBySearch(
      String field, String searchText, String userId) async {
    try {
      final headers = await _getHeaders();
      final requests = _userFields.map((userField) async {
        final encodedFilter = Uri.encodeComponent(
            "contains($field,'$searchText') and Do_Not_Show eq false and $userField eq '$userId'");
        final url = '${ApiConstants.baseUrl}/WP_P_TransportTrackingLineList?'
            '\$filter=$encodedFilter';

        debugPrint('API URL: $url');
        final response = await http.get(Uri.parse(url), headers: headers);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          return (data['value'] as List)
              .map((item) => TransportModel1.fromJson(item))
              .toList();
        }
        return <TransportModel1>[];
      });

      final results = await Future.wait(requests);
      return results.expand((list) => list).toSet().toList();
    } catch (e) {
      debugPrint('Error in _fetchTransportDataBySearch: $e');
      rethrow;
    }
  }

  // Individual field fetch methods
  Future<List<TransportModel1>> fetchExporterNo() async {
    final userId = await StorageManager.readData('userid');
    return _fetchTransportDataByField('Exporter_No', userId);
  }

  Future<List<TransportModel1>> fetchChaNo() async {
    final userId = await StorageManager.readData('userid');
    return _fetchTransportDataByField('CHA_No', userId);
  }

  Future<List<TransportModel1>> fetchShippingLineNo() async {
    final userId = await StorageManager.readData('userid');
    return _fetchTransportDataByField('Shipping_Line_No', userId);
  }

  Future<List<TransportModel1>> fetchImportNO() async {
    final userId = await StorageManager.readData('userid');
    return _fetchTransportDataByField('Importer_No', userId);
  }

  Future<List<TransportModel1>> fetchConsignor() async {
    final userId = await StorageManager.readData('userid');
    return _fetchTransportDataByField('Consignor', userId);
  }

  Future<List<TransportModel1>> fetchConsignee() async {
    final userId = await StorageManager.readData('userid');
    return _fetchTransportDataByField('Consignee', userId);
  }

  // Search methods
  Future<List<TransportModel1>> fetchContainerNo(String searchText) async {
    final userId = await StorageManager.readData('userid');
    return _fetchTransportDataBySearch('Container_No', searchText, userId);
  }

  Future<List<TransportModel1>> fetchGrNo(String searchText) async {
    final userId = await StorageManager.readData('userid');
    return _fetchTransportDataBySearch('GR_No', searchText, userId);
  }

  Future<List<TransportModel1>> listOfTransportData({
    String? containerNoSearch,
    String? grnoSearch,
  }) async {
    try {
      final userId = await StorageManager.readData('userid');

      if (containerNoSearch != null && containerNoSearch.isNotEmpty) {
        return await _fetchTransportDataBySearch(
            'Container_No', containerNoSearch, userId);
      }

      if (grnoSearch != null && grnoSearch.isNotEmpty) {
        return await _fetchTransportDataBySearch('GR_No', grnoSearch, userId);
      }

      final results = await Future.wait([
        fetchExporterNo(),
        fetchChaNo(),
        fetchShippingLineNo(),
        fetchImportNO(),
        fetchConsignor(),
        fetchConsignee()
      ]);

      return results.expand((list) => list).toSet().toList();
    } catch (e) {
      debugPrint('Error in listOfTransportData: $e');
      rethrow;
    }
  }
}
