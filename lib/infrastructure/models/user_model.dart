

import 'api_response_model.dart';

class UserData implements Serializable{
  ApiUser? user;

  UserData({this.user});

  UserData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? ApiUser.fromJson(json['user']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class ApiUser{
  int? id;
  dynamic socketId;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  dynamic bio;
  int? phone;
  String? password;
  bool? suspended;
  bool? isSocialLogin;
  dynamic suspensionReason;
  String? status;
  String? deviceType;
  String? notificationToken;
  bool? active;
  bool? isSubscribeNewsletter;
  Country? country;
  dynamic media;
  String? token;


  ApiUser(
      {this.id,
        this.socketId,
        this.userName,
        this.firstName,
        this.lastName,
        this.email,
        this.bio,
        this.phone,
        this.password,
        this.suspended,
        this.suspensionReason,
        this.status,
        this.deviceType,
        this.notificationToken,
        this.active,
        this.isSubscribeNewsletter,
        this.country,
        this.media,
        this.token});

  ApiUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    socketId = json['socket_id'];
    userName = json['user_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    bio = json['bio'];
    phone = json['phone'];
    password = json['password'];
    suspended = json['suspended'];
    suspensionReason = json['suspension_reason'];
    status = json['status'];
    deviceType = json['device_type'];
    notificationToken = json['notification_token'];
    active = json['active'];
    isSubscribeNewsletter = json['is_subscribe_newsletter'];
    country =
    json['country'] != null ? Country.fromJson(json['country']) : null;
    media = json['media'] != null ? Media.fromJson(json['media']) : null;
    token = json['token'];
    isSocialLogin = json['is_social_login']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['socket_id'] = socketId;
    data['user_name'] = userName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['bio'] = bio;
    data['phone'] = phone;
    data['password'] = password;
    data['suspended'] = suspended;
    data['suspension_reason'] = suspensionReason;
    data['status'] = status;
    data['device_type'] = deviceType;
    data['notification_token'] = notificationToken;
    data['active'] = active;
    data['is_subscribe_newsletter'] = isSubscribeNewsletter;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (media != null) {
      data['media'] = media!.toJson();
    }
    data['token'] = token;
    data['is_social_login'] = isSocialLogin;
    return data;
  }
}

class Country {
  int? id;
  String? name;
  String? dialCode;
  String? emoji;
  String? image;

  Country({this.id, this.name, this.dialCode, this.emoji, this.image});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dialCode = json['dial_code'];
    emoji = json['emoji'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['dial_code'] = dialCode;
    data['emoji'] = emoji;
    data['image'] = image;
    return data;
  }
}

class Media {
  String? mediaPath;
  String? mediaType;
  String? mediaCategory;

  Media({this.mediaPath, this.mediaType, this.mediaCategory});

  Media.fromJson(Map<String, dynamic> json) {
    mediaPath = json['media_path'];
    mediaType = json['media_type'];
    mediaCategory = json['media_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['media_path'] = mediaPath;
    data['media_type'] = mediaType;
    data['media_category'] = mediaCategory;
    return data;
  }
}
