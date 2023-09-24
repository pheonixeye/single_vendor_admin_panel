import 'package:single_vendor_admin_panel/api/constants/servers.dart';
import 'package:single_vendor_admin_panel/api/errors/response_exception.dart';
import 'package:appwrite/appwrite.dart';
// ignore: implementation_imports
import 'package:appwrite/src/enums.dart';

class HxServerStatus {
  const HxServerStatus();

  Future fetchServerStatus(Server server) async {
    final Response response = await server.client.call(
      HttpMethod.get,
      path: "/health",
    );

    if (response.data['status'] == "pass") {
      return response.data['status'];
    } else {
      throw ResponseException(response.data['status']);
    }
  }
}
