class SocialUserModel {
  String? FirstName;
  String? LastName;
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
      this.FirstName,
      this.LastName});

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    FirstName = json['FirstName'];
    LastName = json['LastName'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'FirstName': FirstName,
      'LastName': LastName,
      'email': email,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
    };
  }
}
