import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/api/appusers/hx_appusers.dart';
import 'package:single_vendor_admin_panel/models/app_user_log_model.dart';
import 'package:single_vendor_admin_panel/models/app_user_model.dart';
import 'package:uuid/uuid.dart';

class PxAppUsers extends ChangeNotifier {
  PxAppUsers({required this.usersService});

  AppUserList? _appUserList;
  AppUserList? get appUserList => _appUserList;

  AppUser? _appUser = AppUser.initial();
  AppUser? get appUser => _appUser;

  AppUser? _loggedInAppUser = AppUser.initial();
  AppUser? get loggedInAppUser => _loggedInAppUser;

  Session? _userSession;
  Session? get userSession => _userSession;

  User? _loggedInUser;
  User? get loggedInUser => _loggedInUser;

  AppUserLogData? _logData;
  AppUserLogData? get logData => _logData;

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
    // print(_appUser.toString());
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
      // print(_loggedInUser?.toMap().toString());
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

  Future<AppUserList?> fetchAllAppUsers() async {
    try {
      final u = await usersService.getAllAppUsers();
      _appUserList = u;
      notifyListeners();
      return _appUserList;
    } catch (e) {
      rethrow;
    }
  }

  void updateAppUsersList(AppUser newUser, [bool toRemove = false]) {
    _appUserList = _appUserList?.update(newUser, toRemove);
    notifyListeners();
  }

  Future<AppUser?> fetchOneAppUser(String userId,
      [bool toRemove = false]) async {
    try {
      final u = await usersService.fetchOneAppUser(userId);
      updateAppUsersList(u!, toRemove);

      return u;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateAppUser(AppUser appUser, UserUpdate update) async {
    try {
      await usersService.updateOneAppUser(appUser, update);
      await fetchOneAppUser(appUser.id!);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(AppUser appUser) async {
    try {
      await usersService.deleteAppUser(appUser);
      updateAppUsersList(appUser, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchAppUserLogData() async {
    try {
      final appUserLogData =
          await usersService.fetchUserLogs(_forLogAppUser!.id!);
      _logData = appUserLogData;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  AppUser? _forLogAppUser;
  AppUser? get forLogAppUser => _forLogAppUser;

  void setForLogAppUser(AppUser? newUser) {
    _forLogAppUser = newUser;
    notifyListeners();
  }
}
