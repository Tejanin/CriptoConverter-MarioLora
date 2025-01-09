import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinApiService {
  final String baseUrl = "https://rest.coinapi.io/v1/exchangerate";
  final String apiKey = "453c10c0-10ba-449e-9f2e-c9403f21a576";

  Future<double?> getExchangeRate(String baseAsset, String quoteAsset) async {
    final url = Uri.parse('$baseUrl/$baseAsset/$quoteAsset?ApiKey=$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['rate'];
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching exchange rate: $e');
      return null;
    }
  }
}
