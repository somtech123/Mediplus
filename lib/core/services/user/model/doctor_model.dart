import 'package:flutter/material.dart';

class DoctorModel {
  String? id,
      firstname,
      lastname,
      phone,
      email,
      department,
      designation,
      rating,
      specialist,
      experience,
      fee,
      bio,
      employmentPeriod,
      photo;
  List<TimeOfDay>? morningSlot, noonSlot, nightSlot;

  DoctorModel(
      {this.id,
      this.firstname,
      this.lastname,
      this.phone,
      this.email,
      this.department,
      this.designation,
      this.rating,
      this.specialist,
      this.bio,
      this.employmentPeriod,
      this.experience,
      this.fee,
      this.morningSlot,
      this.nightSlot,
      this.noonSlot,
      this.photo});

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        id: json["id"],
        firstname: json["firstName"],
        lastname: json["lastName"],
        phone: json["phone"],
        email: json["email"],
        department: json['department'],
        designation: json['designation'],
        specialist: json['specialtist'],
        experience: json['experience'],
        rating: json['rating'],
        bio: json['bio'],
        fee: json['consultantancy fee'],
        employmentPeriod: json['employment period'],
        morningSlot: List<TimeOfDay>.from(json['morning slot'])
            .map((e) => firebaseToTimeOfDay(e as Map<String, dynamic>))
            .toList(),
        nightSlot: List<TimeOfDay>.from(json['evening slot'])
            .map((e) => firebaseToTimeOfDay(e as Map<String, dynamic>))
            .toList(),
        noonSlot: List<TimeOfDay>.from(json['afternoon slot'])
            .map((e) => firebaseToTimeOfDay(e as Map<String, dynamic>))
            .toList(),
      );
}

TimeOfDay firebaseToTimeOfDay(Map<String, dynamic> data) {
  return TimeOfDay(hour: data['hour'], minute: data['minutes']);
}

class TimePeiod {
  int? hour, minutes;
}
