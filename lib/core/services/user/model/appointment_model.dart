import 'package:mediplus/core/services/user/model/doctor_model.dart';

class AppointmentModel {
  String? patientName,
      doctorFirstName,
      doctorLastName,
      specialist,
      doctorId,
      doctorPhoto,
      appointmentSN,
      paymentStatus,
      patientWeight,
      appointmentStatus,
      patientPhone,
      appointmentDescrition;

  DateTime? patientDob, appointnmentDate, dateCreated;
  List? report;
  DateTime? appointmentTime;

  AppointmentModel({
    this.patientName,
    this.doctorFirstName,
    this.doctorLastName,
    this.specialist,
    this.patientPhone,
    this.doctorId,
    this.doctorPhoto,
    this.appointmentSN,
    this.paymentStatus,
    this.patientWeight,
    this.appointmentDescrition,
    this.patientDob,
    this.appointnmentDate,
    this.appointmentTime,
    this.report,
    this.appointmentStatus,
    this.dateCreated,
  });

  factory AppointmentModel.fromJson(Map<dynamic, dynamic> json) =>
      AppointmentModel(
        patientName: json['patient_name'],
        doctorFirstName: json['doctor_firstname'],
        doctorLastName: json['doctor_lastname'],
        specialist: json['specialtist'],
        doctorId: json['doctor_id'],
        doctorPhoto: json['doctor_photo'],
        appointmentSN: json['SN'],
        patientPhone: json['patient_phone'],
        paymentStatus: json['payment_status'],
        patientWeight: json['patient_weight'],
        appointmentDescrition: json['appointment_description'],
        appointmentStatus: json['status'],
        patientDob: DateTime.parse(json["patient_DOB"]),
        appointnmentDate: DateTime.parse(json['appointment_date']),
        appointmentTime:
            //TimePeiod.fromJson
            DateTime.parse(json['appointment_time']),
        report: json['report'] ?? [],
        dateCreated: DateTime.parse(json['date_created']),
      );
}

// class Report{
//   String
// }
