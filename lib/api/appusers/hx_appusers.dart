import 'package:appwrite/appwrite.dart' as client_sdk;
import 'package:dart_appwrite/dart_appwrite.dart' as server_sdk;
import 'package:appwrite/models.dart';
import 'package:single_vendor_admin_panel/api/constants/servers.dart';
import 'package:single_vendor_admin_panel/models/app_user_model.dart';

enum UserUpdate {
  mainRole,
  roles,
  emailVerification,
  activity,
}

class HxAppUsers {
  HxAppUsers({
    required this.server,
  });
  final Server server;

  Future<AppUser?> addNewAppUser(AppUser appUser) async {
    final server_sdk.Users users = server_sdk.Users(server.serverClient);

    try {
      final user = await users.create(
        userId: appUser.id!,
        email: appUser.email,
        password: appUser.password,
        name: appUser.name,
      );

      await users.updatePrefs(
        userId: user.$id,
        prefs: {
          "role": appUser.role.name,
        },
      );

      await users.updateEmailVerification(
        userId: user.$id,
        emailVerification: true,
      );

      await users.updateLabels(
        userId: user.$id,
        labels: ['appuser'],
      );

      return AppUser(
        id: user.$id,
        email: user.email,
        password: user.password!,
        name: user.name,
        status: user.status,
        role: UserRole.fromString(user.prefs.data['role']),
        otherRoles: UserRole.userRoleListFromListString(
            user.labels.map((e) => e.toString()).toList()),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteAppUser(AppUser appUser) async {
    final server_sdk.Users users = server_sdk.Users(server.serverClient);
    try {
      final response = await users.delete(userId: appUser.id!);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<AppUserList?> getAllAppUsers() async {
    final server_sdk.Users users = server_sdk.Users(server.serverClient);
    try {
      // server_sdk.Query.search('Labels', 'appuser')
      final response = await users.list(queries: []);
      final filteredAppUsers = response.users
          .map((e) => AppUser(
                id: e.$id,
                email: e.email,
                password: e.password!,
                status: e.status,
                name: e.name,
                role: UserRole.fromString(e.prefs.data['role']),
                otherRoles: UserRole.userRoleListFromListString(
                    e.labels.map((e) => e.toString()).toList()),
              ))
          .toList();
      final result = AppUserList(users: filteredAppUsers);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateOneAppUser(
    AppUser appUser,
    UserUpdate update,
  ) async {
    final server_sdk.Users users = server_sdk.Users(server.serverClient);

    final user = await users.get(userId: appUser.id!);

    switch (update) {
      case UserUpdate.mainRole:
        await users.updatePrefs(
          userId: appUser.id!,
          prefs: {
            'role': appUser.role.name,
          },
        );
      case UserUpdate.roles:
        await users.updateLabels(
          userId: appUser.id!,
          labels: appUser.otherRoles.map((e) => e.name).toList(),
        );
      case UserUpdate.emailVerification:
        await users.updateEmailVerification(
          userId: appUser.id!,
          emailVerification: !user.emailVerification,
        );
      case UserUpdate.activity:
        await users.updateStatus(
          userId: appUser.id!,
          status: !appUser.status,
        );
    }
  }

  Future<String?> clearLoginSessions() async {
    final client_sdk.Account account = client_sdk.Account(server.clientClient);
    try {
      final response = await account.deleteSessions();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getLoggedInUser() async {
    final client_sdk.Account account = client_sdk.Account(server.clientClient);
    try {
      final User response = await account.get();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Session> createEmailSession({
    required String email,
    required String password,
  }) async {
    final client_sdk.Account account = client_sdk.Account(server.clientClient);

    try {
      final Session response = await account.createEmailSession(
        email: email,
        password: password,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Session> createAnonymousSession() async {
    final client_sdk.Account account = client_sdk.Account(server.clientClient);

    try {
      final Session response = await account.createAnonymousSession();

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<AppUser?> fetchOneAppUser(String userId) async {
    final server_sdk.Users users = server_sdk.Users(server.serverClient);
    try {
      final user = await users.get(userId: userId);
      final AppUser appUser = AppUser(
        id: userId,
        email: user.email,
        password: user.password!,
        status: user.status,
        name: user.name,
        role: UserRole.fromString(user.prefs.data['role']),
        otherRoles: UserRole.userRoleListFromListString(
            user.labels.map((e) => e.toString()).toList()),
      );

      return appUser;
    } catch (e) {
      rethrow;
    }
  }
}
