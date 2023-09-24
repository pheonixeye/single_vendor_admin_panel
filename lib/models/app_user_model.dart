import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';

enum UserRole {
  admin("has access to all app privileges."),
  editor("has access to item creation and management"),
  analyst('has access to orders & reports'),
  hr('has access to app users'),
  unknown("for data coherency '**DO NOT SELECT**'");

  final String? description;
  const UserRole(this.description);

  static UserRole fromString(String name) {
    switch (name.toLowerCase()) {
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
  final String email;
  final String password;
  final UserRole role;
  final List<UserRole>? otherRoles;

  AppUser({
    String? id,
    required this.email,
    required this.password,
    required this.role,
    required this.otherRoles,
  }) : _id = id ?? const Uuid().v4();

  factory AppUser.initial() {
    return AppUser(
      email: '',
      password: '',
      role: UserRole.unknown,
      otherRoles: const [],
    );
  }

  AppUser copyWith({
    String? email,
    String? password,
    UserRole? role,
    List<UserRole>? otherRoles,
  }) {
    return AppUser(
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      otherRoles: otherRoles ?? this.otherRoles,
    );
  }

  @override
  List<Object?> get props => [
        _id,
        email,
        password,
        role,
        otherRoles,
      ];

  @override
  String toString() => toJson().toString();

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      email: json['username'],
      password: json['password'],
      role: UserRole.fromString(json['role']),
      otherRoles: (json['other_roles'] as List<String>)
          .map((e) => UserRole.fromString(e))
          .toList(),
      id: json['uuid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": email,
      "password": password,
      "role": role.name,
      "other_roles": otherRoles?.map((e) => e.name).toList(),
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
