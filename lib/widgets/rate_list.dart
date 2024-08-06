import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/exchangerate.dart'; // Assuming you have a model file

class RateList extends StatefulWidget {
  const RateList({super.key});

  @override
  State<RateList> createState() => _RateListState();
}

class _RateListState extends State<RateList> {
  late Future<ExchangeRate?> exchangeRateFuture;

  @override
  void initState() {
    super.initState();
    exchangeRateFuture = fetchExchangeRate();
  }

  Future<ExchangeRate?> fetchExchangeRate() async {
    final response = await http.get(Uri.parse(
        'http://api.exchangerate.host/live?access_key=0e02229f4614a1ee968d2b73c19ecfe0&currencies=AUD,CAD,PLN,MXN&format=1'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse); // For debugging

      try {
        return ExchangeRate.fromJson(jsonResponse);
      } catch (e) {
        print('Error parsing JSON: $e');
        rethrow; // Re-throw the error to be handled in the FutureBuilder
      }
    } else {
      throw Exception('Failed to load exchange rates: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ExchangeRate?>(
      future: exchangeRateFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final exchangeRate = snapshot.data;
          if (exchangeRate != null) {
            final rates = exchangeRate.rates.entries.toList();
            return ListView.builder(
              itemCount: rates.length,
              itemBuilder: (context, index) {
                final rateEntry = rates[index];
                final currency = rateEntry.key;
                final rateValue = rateEntry.value;
                return ListTile(
                  title: Text(currency),
                  subtitle: SelectableText('$rateValue THB'),
                );
              },
            );
          } else {
            return const Text('Failed to load rates');
          }
        }
      },
    );
  }
}
