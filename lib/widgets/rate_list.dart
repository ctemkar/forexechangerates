import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/exchangerate.dart';

class RateList extends StatefulWidget {
  const RateList({super.key});

  @override
  State<RateList> createState() => _RateListState();
}

class _RateListState extends State<RateList> {
  late Future<ExchangeRate> exchangeRateFuture;

  @override
  void initState() {
    super.initState();
    exchangeRateFuture = fetchExchangeRate();
  }

  Future<ExchangeRate> fetchExchangeRate() async {
    const apiKey = '85edb0317a72e6cada0c78df'; // Replace with your API key
    final response = await http.get(
        Uri.parse('https://v6.exchangerate-api.com/v6/$apiKey/latest/THB'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final exchangeRateData =
          jsonResponse['conversion_rates'] as Map<String, dynamic>;

      // Invert rates to get THB as base
      final invertedRates = exchangeRateData.map((key, value) {
        return MapEntry(key, 1 / value);
      });

      return ExchangeRate(
        base: 'THB',
        conversionRates: invertedRates,
      );
    } else {
      throw Exception('Failed to load exchange rates: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ExchangeRate>(
      future: exchangeRateFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final exchangeRate = snapshot.data!;
          final rates = exchangeRate.conversionRates.entries.toList();
          return ListView.builder(
            itemCount: rates.length,
            itemBuilder: (context, index) {
              final rateEntry = rates[index];
              final currency = rateEntry.key;
              final rateValue = rateEntry.value;
              return ListTile(
                title: Text(' $currency ${rateValue.toStringAsFixed(2)}'),
              );
            },
          );
        }
      },
    );
  }
}

class ExchangeRate {
  final String base;
  final Map<String, double> conversionRates;

  ExchangeRate({required this.base, required this.conversionRates});

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      base: json['base_code'],
      conversionRates: json['conversion_rates']
          .cast<String, dynamic>()
          .map((key, value) => MapEntry(key, value as double))
          .toMap(),
    );
  }
}
