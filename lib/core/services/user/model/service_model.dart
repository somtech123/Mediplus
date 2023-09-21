class ServiceChargeModel {
  String? servicesCharge;
  ServiceChargeModel({this.servicesCharge});

  factory ServiceChargeModel.fromJson(Map<String, dynamic> json) =>
      ServiceChargeModel(
        servicesCharge: json['service_charge'],
      );
}
