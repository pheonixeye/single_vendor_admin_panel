import 'package:appwrite/appwrite.dart' as client_sdk;
import 'package:single_vendor_admin_panel/api/constants/servers.dart';
import 'package:single_vendor_admin_panel/constants/creds.dart';
import 'package:single_vendor_admin_panel/models/category_to_product.dart';

class HxCatToProd {
  final Server server;
  late final client_sdk.Databases db;

  HxCatToProd({required this.server}) {
    db = client_sdk.Databases(server.clientClient);
  }

  Future<List<CatToProd>?> listCatToProd() async {
    try {
      final res = await db.listDocuments(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.CAT_PRODS_COLLECTION_ID,
      );

      final List<CatToProd> list = res.documents.map((e) {
        return CatToProd.fromJson(e.data);
      }).toList();

      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<CatToProd?> updateCTP(CatToProd catToProd) async {
    try {
      final res = await db.updateDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.CAT_PRODS_COLLECTION_ID,
        documentId: catToProd.categoryId,
        data: catToProd.toJson(),
      );

      final newCtP = CatToProd.fromJson(res.data);

      return newCtP;
    } catch (e) {
      rethrow;
    }
  }
}
