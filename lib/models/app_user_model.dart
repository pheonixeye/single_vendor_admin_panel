import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';

enum UserRole {
  admin("has access to all app privileges."),
  editor("has access to item creation and management in products page"),
  analyst('has access to orders & reports'),
  hr('has access to admin app & website users'),
  sales('has access to sales dashboard'),
  inventory('has access to inventory & stock panel'),
  unknown("for data coherency '**DO NOT SELECT**'");

  final String description;
  const UserRole(this.description);

  static UserRole fromString(String? name) {
    if (name == null) return UserRole.unknown;
    switch (name.toLowerCase()) {
      case "admin":
        return UserRole.admin;
      case "editor":
        return UserRole.editor;
      case "analyst":
        return UserRole.analyst;
      case "hr":
        return UserRole.hr;
      case "sales":
        return UserRole.sales;
      case "inventory":
        return UserRole.inventory;
      default:
        return UserRole.unknown;
    }
  }

  static List<UserRole> userRoleListFromListString(List<String>? otherRoles) {
    if (otherRoles == null) return [];
    return otherRoles.map((e) => UserRole.fromString(e)).toList();
  }
}

class AppUser extends Equatable {
  final String? id;
  final String email;
  final String name;
  final String password;
  final bool status;
  final UserRole role;
  final List<UserRole> otherRoles;

  AppUser({
    String? id,
    required this.email,
    required this.password,
    required this.name,
    required this.status,
    required this.role,
    required this.otherRoles,
  }) : id = id ?? const Uuid().v4();

  factory AppUser.initial() {
    return AppUser(
      email: '',
      password: '',
      name: '',
      status: true,
      role: UserRole.unknown,
      otherRoles: const [],
    );
  }

  AppUser copyWith({
    String? id,
    String? email,
    String? password,
    String? name,
    bool? status,
    UserRole? role,
    List<UserRole>? otherRoles,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      status: status ?? this.status,
      role: role ?? this.role,
      otherRoles: otherRoles ?? this.otherRoles,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        password,
        name,
        status,
        role,
        otherRoles,
      ];

  @override
  String toString() => toJson().toString();

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      email: json['username'],
      password: json['password'],
      name: json['name'],
      status: json['status'],
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
      'name': name,
      'status': status,
      "role": role.name,
      "other_roles": otherRoles.map((e) => e.name).toList(),
      "uuid": id ?? const Uuid().v4(),
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

  AppUserList update(AppUser newUser, [bool toRemove = false]) {
    List<AppUser> _new = [];
    users.map((e) {
      if (toRemove) {
        _new = users.where((e) => e.id != newUser.id).toList();
      } else {
        if (e.id == newUser.id) {
          _new.add(newUser);
        } else {
          _new.add(e);
        }
      }
    }).toList();
    return AppUserList(users: _new);
  }

  List<Map<String, dynamic>> toJson() {
    return users.map((e) => e.toJson()).toList();
  }
}
