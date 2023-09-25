import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:single_vendor_admin_panel/api/constants/servers.dart';

class HxServerStatus {
  const HxServerStatus();

  Future<String?> fetchServerStatus(Server server) async {
    final serverClient = server.serverClient;
    final health = Health(serverClient);

    try {
      final response = await health.get();
      return response.status;
    } catch (e) {
      rethrow;
    }
  }
}
