import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';

enum UserRole {
  admin("has access to all app privileges."),
  editor("has access to item creation and management"),
  analyst('has access to orders & reports'),
  hr('has access to app users'),
  unknown("for data coherency 'DO NOT SELECT'");

  final String? description;
  const UserRole(this.description);

  static UserRole fromString(String name) {
    switch (name) {
      case "admin":
        return UserRole.admin;
      case "editor":
        return UserRole.editor;
      case "analyst":
        return UserRole.analyst;
      case "hr":
        return UserRole.hr;
      default:
        return UserRole.unknown;
    }
  }
}

class AppUser extends Equatable {
  final String? _id;
  final String userName;
  final String password;
  final UserRole role;

  AppUser({
    String? id,
    required this.userName,
    required this.password,
    required this.role,
  }) : _id = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [_id, userName, password, role];

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      userName: json['username'],
      password: json['password'],
      role: UserRole.fromString(json['role']),
      id: json['uuid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": userName,
      "password": password,
      "role": role.name,
      "uuid": _id ?? const Uuid().v4(),
    };
  }
}

class AppUserList extends Equatable {
  final List<AppUser> users;

  const AppUserList({required this.users});

  @override
  List<Object?> get props => [users];

  factory AppUserList.fromJson(List<Map<String, dynamic>> json) {
    return AppUserList(
      users: json.map((e) => AppUser.fromJson(e)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return users.map((e) => e.toJson()).toList();
  }
}
