  class CreateAccountModel {
  int? userId;
  String? usertype;
  String? fullname;
  String? email;
  String? mobileNo;

  CreateAccountModel(
      {this.userId, this.usertype, this.fullname, this.email, this.mobileNo});

  CreateAccountModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    usertype = json['usertype'];
    fullname = json['fullname'];
    email = json['email'];
    mobileNo = json['mobileNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['usertype'] = this.usertype;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    return data;
  }
}

class PostCreateModel {
  String fullName;

  String email;
  String mobileNo;
  String password;
  String confirmPassword;

  PostCreateModel({
    required this.fullName,
    required this.email,
    required this.mobileNo,
    required this.password,
    required this.confirmPassword,
  });

  factory PostCreateModel.fromJson(Map<String, dynamic> json) {
    return PostCreateModel(
      fullName: json['fullName'],
      email: json['email'],
      mobileNo: json['mobileNo'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    return data;
  }
}
