import 'dart:convert';

UsersList usersFromJson(String str) => UsersList.fromJson(json.decode(str));

String usersToJson(UsersList data) => json.encode(data.toJson());

class UsersList {
  int userid;
  String username;
  String email;
  String password;
  UsersList({
    required this.userid,
    required this.username,
    required this.email,
    required this.password,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': userid,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  factory UsersList.fromJson(Map<String, dynamic> json) {
    return UsersList(
        userid: json['user_id'],
        username: json['username'],
        email: json['email'],
        password: json['password']);
  }
}
// User List