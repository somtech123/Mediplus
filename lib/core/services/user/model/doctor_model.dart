import 'package:cloud_firestore/cloud_firestore.dart';
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
      fee,
      bio,
      patient,
      employmentPeriod,
      hospital,
      photo;
  List<TimePeiod>? morningSlot, noonSlot, nightSlot;
  DateTime? experience;

  DoctorModel(
      {this.id,
      this.firstname,
      this.lastname,
      this.phone,
      this.email,
      this.patient,
      this.department,
      this.designation,
      this.rating,
      this.specialist,
      this.bio,
      this.employmentPeriod,
      this.experience,
      this.fee,
      this.hospital,
      this.morningSlot,
      this.nightSlot,
      this.noonSlot,
      this.photo});

  factory DoctorModel.fromJson(Map<dynamic, dynamic> json) => DoctorModel(
        id: json["id"],
        firstname: json["firstName"],
        lastname: json["lastName"],
        phone: json["phone"],
        email: json["email"],
        hospital: json['hospital'],
        department: json['department'],
        designation: json['designation'],
        specialist: json['specialtist'],
        experience: _parseTimestamp(json['experience']),
        //(json['experience'] as Timestamp).toDate(),
        // json['experience'] as Timestamp,
        rating: json['rating'],
        bio: json['bio'],
        patient: json['patient'],
        photo: json["profileImage"],
        fee: json['consultantancy fee'],
        employmentPeriod: json['employment period'],
        morningSlot: List.from(json['morning slot'] ?? [])
            .map((e) => TimePeiod.fromJson(e))
            .toList(),
        noonSlot: List.from(json['afternoon slot'] ?? [])
            .map((e) => TimePeiod.fromJson(e))
            .toList(),
        nightSlot: List.from(json['evening slot'] ?? [])
            .map((e) => TimePeiod.fromJson(e))
            .toList(),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "firstName": firstname,
        "lastName": lastname,
        "phone": phone,
        "email": email,
        'department': department,
        'designation': designation,
        'specialtist': specialist,
        'experience': experience!.toIso8601String(),
        'rating': rating,
        'bio': bio,
        'patient': patient,
        'hospital': hospital,
        "profileImage": photo,
        'consultantancy fee': fee,
        'employment period': employmentPeriod,
        'morning slot': List<dynamic>.from(morningSlot!.map((x) => x.toJson())),
        'afternoon slot': List<dynamic>.from(noonSlot!.map((x) => x.toJson())),
        'evening slot': List<dynamic>.from(nightSlot!.map((x) => x.toJson())),
      };

  static DateTime? _parseTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    } else if (timestamp is String) {
      return DateTime.tryParse(timestamp);
    }
    return null;
  }
}

class TimePeiod {
  int? hour, minutes;
  TimePeiod({
    this.hour,
    this.minutes,
  });

  factory TimePeiod.fromJson(Map<dynamic, dynamic> data) =>
      TimePeiod(hour: data['hour'], minutes: data['minutes']);

  Map<String?, dynamic> toJson() => {'hour': hour, 'minutes': minutes};
}

firebaseToTimeOfDay(TimeOfDay timeOfDay) {
  return {
    'hour': timeOfDay.hour,
    'minute': timeOfDay.minute,
  };
}
