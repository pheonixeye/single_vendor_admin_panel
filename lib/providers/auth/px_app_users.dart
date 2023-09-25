import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/api/appusers/hx_appusers.dart';
import 'package:single_vendor_admin_panel/models/app_user_model.dart';
import 'package:uuid/uuid.dart';

class PxAppUsers extends ChangeNotifier {
  PxAppUsers({required this.usersService});

  AppUser? _appUser = AppUser.initial();
  AppUser? get appUser => _appUser;

  AppUser? _loggedInAppUser = AppUser.initial();
  AppUser? get loggedInAppUser => _loggedInAppUser;

  Session? _userSession;
  Session? get userSession => _userSession;

  User? _loggedInUser;
  User? get loggedInUser => _loggedInUser;

  final HxAppUsers usersService;

  void setAppUser({
    String? email,
    String? name,
    String? password,
    UserRole? role,
    List<UserRole>? otherRoles,
  }) {
    _appUser = _appUser?.copyWith(
      id: const Uuid().v4(),
      email: email,
      name: name,
      password: password,
      role: role,
      otherRoles: otherRoles,
    );
    notifyListeners();
    print(_appUser.toString());
  }

  Future<void> createAppUser() async {
    try {
      await usersService.addNewAppUser(appUser!);
    } catch (e) {
      rethrow;
    }
  }

  Future<Session> createEmailSession() async {
    try {
      var res = await usersService.createEmailSession(
        email: appUser!.email,
        password: appUser!.password,
      );

      _userSession = res;
      notifyListeners();
      return _userSession!;
    } catch (e) {
      rethrow;
    }
  }

  Future<AppUser?> fetchLoggedInUser() async {
    try {
      var usr = await usersService.getLoggedInUser();
      _loggedInUser = usr;
      _loggedInAppUser = _loggedInAppUser?.copyWith(
        email: _loggedInUser?.email,
        password: _loggedInUser?.password,
        name: _loggedInUser?.name,
        id: _loggedInUser?.$id,
        role: UserRole.fromString(_loggedInUser?.prefs.data['role']),
        otherRoles: UserRole.userRoleListFromListString(
            _loggedInUser?.labels.map((e) => e.toString()).toList()),
      );
      notifyListeners();
      return _loggedInAppUser;
    } catch (e) {
      rethrow;
    }
  }

  Future<Session> createAnonymousSession() async {
    try {
      var res = await usersService.createAnonymousSession();
      _userSession = res;
      notifyListeners();
      return _userSession!;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> clearLoginSessions() async {
    try {
      await usersService.clearLoginSessions();
    } catch (e) {
      rethrow;
    }
  }
}
