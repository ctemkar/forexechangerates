class ExchangeRate {
  final String base;
  final Map<String, double> rates;

  ExchangeRate({required this.base, required this.rates});

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      base: json['base'],
      rates: Map.from(json['rates']),
    );
  }
}
