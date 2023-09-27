import 'package:cloud_firestore/cloud_firestore.dart';

class FavouriteModel {
  bool? isfavourite;
  String? receiverID;
  Timestamp? addedOn;
  FavouriteModel({this.isfavourite, this.receiverID, this.addedOn});

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
      isfavourite: json['isFvourite'],
      receiverID: json['receiverId'],
      addedOn: json['created_at']);

  Map<String?, dynamic> toJson() => {
        'isFvourite': isfavourite,
        'receiverId': receiverID,
        'created_at': addedOn,
      };

  Map<String, dynamic> toMap(FavouriteModel favouriteModel) {
    var data = Map<String, dynamic>();

    data['isFvourite'] = favouriteModel.isfavourite;
    data['receiverId'] = favouriteModel.receiverID;
    data['created_at'] = favouriteModel.addedOn;

    return data;
  }
}
