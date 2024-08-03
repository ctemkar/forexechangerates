import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExchangeRatesScreen extends StatefulWidget {
  @override
  _ExchangeRatesScreenState createState() => _ExchangeRatesScreenState();
}

class _ExchangeRatesScreenState extends State<ExchangeRatesScreen>
 {
  final String apiKey = 'fa0869ef1ff3410f9277d38213a77e6c';
  Map<String, dynamic> _exchangeRates = {};

  Future<void> fetchExchangeRates() async {
    final response = await http.get(Uri.parse('https://openexchangerates.org/api/latest.json?app_id=fa0869ef1ff3410f9277d38213a77e6c'));
    if (response.statusCode == 200) {
      setState(() {
        _exchangeRates = jsonDecode(response.body);
      });
    } else {
      // Handle error
      print('Error fetching exchange rates: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 
 Text('Exchange Rates'),
      ),
      body: 
 FutureBuilder(
        future: fetchExchangeRates(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) 
 {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else
 {
            final rates = _exchangeRates['rates'] as Map<String, dynamic>;
            return ListView.builder(
              itemCount: rates.length,
              itemBuilder: (context, index) {
                final currency = rates.keys.elementAt(index);
                final rate = rates[currency];
                return ListTile(
                  title: Text(currency), 

                  subtitle: Text('Rate: $rate'),
                );
              },
            );
          }
        },
      ),
    );
  }
}