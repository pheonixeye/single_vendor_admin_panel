import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:single_vendor_admin_panel/api/constants/servers.dart';
import 'package:single_vendor_admin_panel/models/app_user_model.dart';

class HxAppUsers {
  HxAppUsers({
    required this.server,
  });
  final Server server;

  Future<User?> addNewAppUser(AppUser appUser) async {
    final Account account = Account(server.client);

    try {
      final User response = await account.create(
        userId: appUser.id!,
        email: appUser.email,
        password: appUser.password,
        name: appUser.role.name,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> deleteAppUser(AppUser appUser) async {}

  Future<AppUserList?> getAllAppUsers() async {}

  Future<String?> updateOneAppUser(AppUser appUser) async {}

  Future<String?> clearLoginSessions() async {
    final Account account = Account(server.client);
    try {
      final response = await account.deleteSessions();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getLoggedInUser() async {
    final Account account = Account(server.client);
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
    final Account account = Account(server.client);

    try {
      final Session response =
          await account.createEmailSession(email: email, password: password);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Session> createAnonymousSession() async {
    final Account account = Account(server.client);

    try {
      final Session response = await account.createAnonymousSession();

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
