import 'package:intl/intl.dart';

class UserModel {
  String? userName;
  String? id;
  String? profileImage;
  String? firstName;
  String? lastName;
  String? gender;
  String? country;
  String? state;
  String? phone;
  String? email;
  DateTime? birthDate;
  DateTime? dateCreated;
  String? bio;

  UserModel(
      {this.userName,
      this.id,
      this.profileImage,
      this.firstName,
      this.lastName,
      this.state,
      this.gender,
      this.country,
      this.phone,
      this.email,
      this.birthDate,
      this.dateCreated,
      this.bio});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userName: json["userName"],
        id: json["id"],
        profileImage: json["profileImage"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"].toString(),
        country: json["country"],
        phone: json["phone"],
        email: json["email"],
        bio: json["bio"],
        state: json['state'],
        birthDate: json["birthDate"] != ''
            ? DateTime.parse(json["birthDate"])
            : DateTime.now(),
        dateCreated: DateTime.parse(json["dateCreated"]),
      );

  Map<String?, dynamic> toJson() => {
        "userName": userName,
        "id": id,
        "profileImage": profileImage,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "country": country,
        "phone": phone,
        "email": email,
        "bio": bio,
        'state': state,
        "birthDate": birthDate!.toIso8601String(),
        "dateCreated": dateCreated!.toIso8601String(),
      };
}
