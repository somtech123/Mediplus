import '../../../constant/string_constant.dart';

class ChatUserModel {
  final String? userId;
  final String? firstname;
  final String? userName;
  final String? lastname;
  //final String? email;
  final String? phone;
  final String? profileUrl;
  final int? state;

  ChatUserModel(
      {this.userName,
      this.userId,
      this.firstname,
      this.lastname,
      this.phone,
      this.profileUrl,
      this.state});

  factory ChatUserModel.fromMap(Map<String, dynamic> json) => ChatUserModel(
      userId: json["id"],
      firstname: json["firstName"],
      lastname: json["lastName"],
      phone: json["phone"],
      profileUrl: json["profileImage"] ?? StringConstants.dummyProfilePicture);

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "firstname": firstname,
        "lastname": lastname,
        "profileUrl": profileUrl,
        'phone': phone
      };
}
