import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserData {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String photoUrl;
  final String payLoadData;
  final LoginMethod loginMethod;

  const UserData(
      {required this.loginMethod,
      this.id = '',
      this.name = '',
      this.email = '',
      this.mobile = '',
      this.photoUrl = '',
      this.payLoadData = ''});

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "photoUrl": photoUrl,
        "payLoadData": payLoadData,
        "loginMethod": loginMethod?.toString(),
      };

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        mobile: json['mobile'],
        photoUrl: json['photoUrl'],
        payLoadData: json['payLoadData'],
        loginMethod: LoginMethod.fromString(json['loginMethod']),
      );

  factory UserData.fromGmailResponse(GoogleSignInAccount account) {
    return UserData(
      id: account.id,
      loginMethod: LoginMethod.Gmail,
      name: account.displayName ?? '',
      email: account.email,
      photoUrl: account.photoUrl ?? '',
    );
  }

  factory UserData.fromFacebookResponse(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? '',
      loginMethod: LoginMethod.Facebook,
      name: json['name'] ?? '',
      email: json['email'],
      photoUrl: json['picture']['data']['url'] ?? '',
    );
  }
}

class LoginMethod extends Equatable {
  final String _value;

  LoginMethod._(this._value);

  static final LoginMethod Gmail = LoginMethod._('gmail');
  static final LoginMethod Facebook = LoginMethod._('facebook');
  static final LoginMethod PhoneAndPassword = LoginMethod._('phoneAndPassword');
  static final LoginMethod Apple = LoginMethod._('apple');
  static final LoginMethod None = LoginMethod._('none');

  factory LoginMethod.fromString(String value) {
    switch (value.toLowerCase().trim().toString()) {
      case 'gmail':
        return Gmail;
      case 'facebook':
        return Facebook;
      case 'phoneandpassword':
        return PhoneAndPassword;
      case 'apple':
        return Apple;
      default:
        return None;
    }
  }

  @override
  List<Object?> get props => [_value];

  @override
  String toString() => _value;
}
