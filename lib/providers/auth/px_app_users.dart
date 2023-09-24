import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/api/appusers/hx_appusers.dart';
import 'package:single_vendor_admin_panel/models/app_user_model.dart';
import 'package:single_vendor_admin_panel/providers/px_server_status_px.dart';

class PxAppUsers extends ChangeNotifier {
  AppUser _appUser = AppUser.initial();
  AppUser get appUser => _appUser;

  dynamic _userSession;
  dynamic get userSession => _userSession;

  final HxAppUsers usersService = HxAppUsers(
    server: PxServerStatus().server,
  );

  void setAppUser({
    String? email,
    String? password,
    UserRole? role,
    List<UserRole>? otherRoles,
  }) {
    _appUser = _appUser.copyWith(
      email: email,
      password: password,
      role: role,
      otherRoles: otherRoles,
    );
    notifyListeners();
  }

  Future<String?> createAppUser() async {
    try {
      var response = await usersService.addNewAppUser(appUser);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Session> createEmailSession() async {
    try {
      var res = await usersService.createEmailSession(
        email: appUser.email,
        password: appUser.password,
      );

      _userSession = res;
      notifyListeners();
      return _userSession;
    } catch (e) {
      rethrow;
    }
  }

  Future<Session> createAnonymousSession() async {
    try {
      var res = await usersService.createAnonymousSession();
      _userSession = res;
      notifyListeners();
      return _userSession;
    } catch (e) {
      rethrow;
    }
  }
}
