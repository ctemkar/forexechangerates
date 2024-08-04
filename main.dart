import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, double>> fetchExchangeRatesDirectly() async {
  const apiKey = 'fa0869ef1ff3410f9277d38213a77e6c';
  const baseUrl = 'https://openexchangerates.org/api';
  const latestEndpoint = '/latest.json';

  final response =
      await http.get(Uri.parse('$baseUrl$latestEndpoint?app_id=$apiKey'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final rates = data['rates'] as Map<String, double>;

    // Extract desired currencies as before

    return rates;
  } else {
    throw Exception('Failed to fetch exchange rates');
  }
}
