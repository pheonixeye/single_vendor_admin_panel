import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:single_vendor_admin_panel/api/constants/servers.dart';
import 'package:single_vendor_admin_panel/models/app_user_model.dart';

class HxAppUsers {
  HxAppUsers({
    Server? server,
  }) : _server = server ?? Server.dev();
  final Server _server;

  Future<String?> addNewAppUser(AppUser appUser) async {}

  Future<String?> deleteAppUser(AppUser appUser) async {}

  Future<AppUserList?> getAllAppUsers() async {}

  Future<AppUser?> getOneAppUserByUuid(String uuid) async {}

  Future<String?> updateOneAppUser(AppUser appUser) async {}

  Future<Session> createEmailSession({
    required String email,
    required String password,
  }) async {
    final Account account = Account(_server.client);

    try {
      final Session response =
          await account.createEmailSession(email: email, password: password);

      print(response.toMap().toString());

      return response;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<Session> createAnonymousSession() async {
    final Account account = Account(_server.client);
    try {
      final Session response = await account.createAnonymousSession();

      print(response.toMap().toString());

      return response;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
