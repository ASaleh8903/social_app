class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVerified;
  String? image;
  String? cover;
  String? bio;

  SocialUserModel(
      {this.email,
      this.phone,
      this.uId,
      this.isEmailVerified,
      this.bio,
      this.image,
      this.cover,
      this.name});

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
    };
  }
}
