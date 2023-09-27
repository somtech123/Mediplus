import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatMessageModel2 {
  final String? senderId;
  final String? receiverId;
  final String? type;
  final String? message;
  String? photoUrl;
  final Timestamp? timestamp;

  ChatMessageModel2(
      {this.timestamp,
      this.senderId,
      this.receiverId,
      this.type,
      this.message,
      this.photoUrl});

  ChatMessageModel2.imageMessage(
      {this.photoUrl,
      this.timestamp,
      this.senderId,
      this.receiverId,
      this.type,
      this.message});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['type'] = this.type;
    map['message'] = this.message;
    map['photoUrl'] = this.photoUrl;
    map['timestamp'] = this.timestamp;

    return map;
  }

  factory ChatMessageModel2.fromMap(Map<String, dynamic> json) =>
      ChatMessageModel2(
          senderId: json['senderId'],
          receiverId: json['receiverId'],
          type: json['type'],
          message: json['message'],
          photoUrl: json['photoUrl'],
          timestamp: json['timestamp']);

  Map<String, dynamic> toImageMap() {
    var map = Map<String, dynamic>();
    map['message'] = this.message;
    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['type'] = this.type;
    map['timestamp'] = this.timestamp;
    map['photoUrl'] = this.photoUrl;
    return map;
  }
}

class ChatMessageModel {
  ChatMessageModel({
    required this.user,
    required this.createdAt,
    required this.text,
    this.userId,
    this.medias,
    this.quickReplies,
    this.customProperties,
    this.mentions,
    this.status = MessageStatus.none,
    this.replyTo,
  });

  /// Create a ChatMessageModel instance from json data
  factory ChatMessageModel.fromJson(Map<String, dynamic> jsonData) {
    return ChatMessageModel(
      user: ChatUser.fromJson(jsonData['user'] as Map<String, dynamic>),

      createdAt: jsonData['timestamp'],
      text: jsonData['text']?.toString() ?? '',
      medias: jsonData['medias'] != null
          ? (jsonData['medias'] as List<dynamic>)
              .map((dynamic media) =>
                  ChatMedia.fromJson(media as Map<String, dynamic>))
              .toList()
          : <ChatMedia>[],
      quickReplies: jsonData['quickReplies'] != null
          ? (jsonData['quickReplies'] as List<dynamic>)
              .map((dynamic quickReply) =>
                  QuickReply.fromJson(quickReply as Map<String, dynamic>))
              .toList()
          : <QuickReply>[],
      //  customProperties: jsonData['customProperties'] as Map<String, dynamic>,
      mentions: jsonData['mentions'] != null
          ? (jsonData['mentions'] as List<dynamic>)
              .map((dynamic mention) =>
                  Mention.fromJson(mention as Map<String, dynamic>))
              .toList()
          : <Mention>[],
      // status: MessageStatus.parse(jsonData['status'].toString()),
      replyTo: jsonData['replyTo'] != null
          ? ChatMessage.fromJson(jsonData['replyTo'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Text of the message (optional because you can also just send a media)
  String text;

  String? userId;

  /// Author of the message
  ChatUser user;

  /// List of medias of the message
  List<ChatMedia>? medias;

  /// A list of quick replies that users can use to reply to this message
  List<QuickReply>? quickReplies;

  /// A list of custom properties to extend the existing ones
  /// in case you need to store more things.
  /// Can be useful to extend existing features
  Map<String, dynamic>? customProperties;

  /// Date of the message
  Timestamp createdAt;

  /// Mentionned elements in the message
  List<Mention>? mentions;

  /// Status of the message TODO:
  MessageStatus? status;

  /// If the message is a reply of another one TODO:
  ChatMessage? replyTo;

  /// Convert a ChatMessage into a json
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user_id': user.id,
      'user': user.toJson(),
      'timestamp': createdAt,
      'text': text,
      'medias': medias?.map((ChatMedia media) => media.toJson()).toList(),
      'quickReplies': quickReplies
          ?.map((QuickReply quickReply) => quickReply.toJson())
          .toList(),
      // 'customProperties': customProperties,
      'mentions': mentions,
      'status': status.toString(),
      'replyTo': replyTo?.toJson(),
    };
  }
}
