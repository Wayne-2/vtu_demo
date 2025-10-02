import 'dart:convert';
import 'package:http/http.dart' as http;

class VtuService {
  final String baseUrl = "https://sandbox.vtpass.com/api/"; // change to real base URL
  final String apiKey = "382b853d8cd5146813d9af24d2e10d16";
  final String publicKey = "PK_906cf2d06917b40bd8e9b0254cdfdddcbed00732a14";
  final String secretKey = "SK_990789c4658020d4a862ab0d7effed4c3e2cdf526ba";

  Future<Map<String, dynamic>> buy({
    required String network,
    required String mobile,
    required String amount,
    required String type, // Airtime | Data
  }) async {
    final url = Uri.parse(baseUrl);

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "api-key": apiKey,
        "public-key": publicKey,
        "secret-key": secretKey,
      },
      body: jsonEncode({
        "serviceID": type.toLowerCase() == "airtime" ? "mtn" : "mtn-data", 
        "amount": amount,
        "phone": mobile,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to complete transaction: ${response.body}");
    }
  }
}

