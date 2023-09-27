class CurrencyModel {
  double? total;
  double? rate;
  // From from;
  // From to;
  //int timestamp;

  CurrencyModel({
    this.total,
    this.rate,
    // required this.from,
    // required this.to,
    // required this.timestamp,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        total: json["total"]?.toDouble(),
        rate: json["rate"]?.toDouble(),
        // from: From.fromJson(json["from"]),
        // to: From.fromJson(json["to"]),
        // timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "rate": rate,
        // "from": from.toJson(),
        // "to": to.toJson(),
        // "timestamp": timestamp,
      };
}

class From {
  double rate;
  String currency;

  From({
    required this.rate,
    required this.currency,
  });

  factory From.fromJson(Map<String, dynamic> json) => From(
        rate: json["rate"]?.toDouble(),
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "currency": currency,
      };
}
