import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/api/appusers/hx_appusers.dart';
import 'package:single_vendor_admin_panel/models/app_user_model.dart';

class PxAppUsers extends ChangeNotifier {
  AppUser? _appUser = AppUser.initial();

  PxAppUsers({required this.usersService});
  AppUser? get appUser => _appUser;

  Session? _userSession;
  Session? get userSession => _userSession;

  User? _loggedInUser;
  User? get loggedInUser => _loggedInUser;

  final HxAppUsers usersService;

  void setAppUser({
    String? email,
    String? password,
    UserRole? role,
    List<UserRole>? otherRoles,
  }) {
    _appUser = _appUser?.copyWith(
      email: email,
      password: password,
      role: role,
      otherRoles: otherRoles,
    );
    notifyListeners();
  }

  Future<AppUser?> createAppUser() async {
    try {
      final User? user = await usersService.addNewAppUser(appUser!);
      _appUser = _appUser?.copyWith(
        email: user?.email,
        password: user?.password,
        id: user?.$id,
        role: user?.name != null
            ? UserRole.fromString(user!.name)
            : UserRole.unknown,
      );
      notifyListeners();
      return _appUser;
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
      _appUser = _appUser?.copyWith(
        email: _loggedInUser?.email,
        password: _loggedInUser?.password,
        id: _loggedInUser?.$id,
        role: _loggedInUser?.name == null
            ? UserRole.unknown
            : UserRole.fromString(_loggedInUser!.name),
      );
      notifyListeners();
      return _appUser;
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
