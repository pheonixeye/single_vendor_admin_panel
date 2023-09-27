import 'package:appwrite/appwrite.dart' as client_sdk;
import 'package:single_vendor_admin_panel/api/constants/servers.dart';
import 'package:single_vendor_admin_panel/constants/creds.dart';

class HxProducts {
  HxProducts({required this.server});
  final Server server;

  Future<String?> fetchProducts() async {
    try {
      final db = client_sdk.Databases(server.clientClient);
      final products = await db.listDocuments(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCTS_COLLECTION_ID,
      );
      return products.toMap().toString();
    } catch (e) {
      rethrow;
    }
  }
}
