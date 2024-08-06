class ExchangeRate {
  final String source; // Source currency (USD in this case)
  final Map<String, double> rates; // Map of currency codes to exchange rates

  ExchangeRate({required this.source, required this.rates});

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      source: json['source'] as String, // Ensure source is a String
      rates: json['quotes']?.cast<String, double>() ??
          {}, // Handle potential null value for 'quotes'
    );
  }
}
