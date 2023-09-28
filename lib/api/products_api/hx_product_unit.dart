import 'package:appwrite/appwrite.dart' as client_sdk;
import 'package:single_vendor_admin_panel/api/constants/servers.dart';
import 'package:single_vendor_admin_panel/constants/creds.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';

class HxProductUnit {
  HxProductUnit({required this.server});
  final Server server;

  Future<String?> fetchProducts() async {
    try {
      final db = client_sdk.Databases(server.clientClient);
      final products = await db.listDocuments(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_COLLECTION_ID,
      );
      return products.toMap().toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductUnit>> listProductUnits() async {
    try {
      final db = client_sdk.Databases(server.clientClient);
      final docs = await db.listDocuments(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_UNIT_COLLECTION_ID,
      );

      List<ProductUnit> units = docs.documents.map((e) {
        return ProductUnit.fromJson(e.data);
      }).toList();

      return units;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductUnit> createProductUnit(ProductUnit unit) async {
    try {
      final db = client_sdk.Databases(server.clientClient);
      final doc = await db.createDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_UNIT_COLLECTION_ID,
        documentId: unit.unitId,
        data: unit.toJson(),
      );
      return ProductUnit.fromJson(doc.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteProductUnit(String unitId) async {
    try {
      final db = client_sdk.Databases(server.clientClient);
      final doc = await db.deleteDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_UNIT_COLLECTION_ID,
        documentId: unitId,
      );
      return doc;
    } catch (e) {
      rethrow;
    }
  }
}
