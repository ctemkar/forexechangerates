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
    final response = await http.get(Uri.parse(
        'http://data.fixer.io/api/latest?access_key=da4843f1844d1c12d4f3978023d85380'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return ExchangeRate.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load exchange rates');
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
          return Text('${snapshot.error}');
        } else {
          final exchangeRate = snapshot.data!;
          final rates = exchangeRate.rates.entries.toList();
          return ListView.builder(
            itemCount: rates.length,
            itemBuilder: (context, index) {
              final rate = rates[index];
              return ListTile(
                title: SelectableText(rate.key),
                subtitle: SelectableText('${rate.value} ${exchangeRate.base}'),
              );
            },
          );
        }
      },
    );
  }
}
