class CountryModel {
  final String country;

  final List<String> states;
  final String alpha2code;

  CountryModel({
    required this.country,
    required this.states,
    required this.alpha2code,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      country: json['country'],
      states: List<String>.from(json['states']),
      alpha2code: json["alpha2Code"],
    );
  }
}
