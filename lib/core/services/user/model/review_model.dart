class ReviewModel {
  String? firstname, lastname;
  String? rating;
  String? comment;
  String? photo;
  DateTime? dateCreated;

  ReviewModel(
      {this.firstname,
      this.lastname,
      this.rating,
      this.comment,
      this.photo,
      this.dateCreated});

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
      firstname: json['fistname'],
      lastname: json['lastname'],
      rating: json['rating'],
      comment: json['comment'],
      photo: json['photoUrl'],
      dateCreated: DateTime.parse(json['date_created']));

  Map<String?, dynamic> toJson() => {
        'fistname': firstname,
        'lastname': lastname,
        'rating': rating,
        'comment': comment,
        'photoUrl': photo
      };

  Map<String, dynamic> toMap(ReviewModel reviewModel) {
    var json = Map<String, dynamic>();

    json['fistname'] = reviewModel.firstname;
    json['lastname'] = reviewModel.lastname;
    json['rating'] = reviewModel.rating;
    json['comment'] = reviewModel.comment;

    return json;
  }
}
