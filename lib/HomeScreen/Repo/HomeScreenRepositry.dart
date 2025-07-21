import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../ALL URL.dart'; // Ensure ApiConstants.baseUrl is correct
import '../../TokenRepo.dart'; // To get the Bearer token

class HomeScreenRepository {
  Future<List<String>> fetchImageUrls() async {
    const String imageBasePath = "https://connect.thethardryport.in/";
    final String apiUrl = "${ApiConstants.baseUrl}/WP_P_WebImageCard?\$filter=Images eq true";

    try {
      // Get bearer token from TokenRepository
      final tokenRepo = TokenRepository();
      final token = await tokenRepo.getLoginOdataToken();

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Prefer': 'odata.include-annotations="*"',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final imageList = (data['value'] as List)
            .map((item) => item['Image_Path']?.toString())
            .where((path) => path != null && path.isNotEmpty)
            .map((path) => imageBasePath + path!)
            .toList();

        return imageList;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}

