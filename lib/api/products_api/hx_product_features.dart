import 'package:appwrite/appwrite.dart' as client_sdk;
import 'package:single_vendor_admin_panel/api/constants/servers.dart';
import 'package:single_vendor_admin_panel/constants/creds.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';
import 'package:uuid/uuid.dart';

class HxProductFeatures {
  final Server server;
  late final client_sdk.Databases db;

  HxProductFeatures({required this.server}) {
    db = client_sdk.Databases(server.clientClient);
  }

  Future<ProductFeature?> createFeature(ProductFeature feature) async {
    try {
      final res = await db.createDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_FEATURES_COLLECTION_ID,
        documentId: const Uuid().v4(),
        data: feature.toJson(),
      );

      final productFeature = ProductFeature.fromJson(res.data);

      return productFeature;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductFeature?> updateFeature(ProductFeature newFeature) async {
    try {
      final res = await db.updateDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_FEATURES_COLLECTION_ID,
        documentId: newFeature.id!,
        data: newFeature.toJson(),
      );

      final productFeature = ProductFeature.fromJson(res.data);

      return productFeature;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteFeature(ProductFeature feature) async {
    try {
      final res = await db.deleteDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_FEATURES_COLLECTION_ID,
        documentId: feature.id!,
      );

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductFeature>?> listFeatures(String productId) async {
    try {
      final res = await db.listDocuments(
          databaseId: CREDS.DATABASE_ID,
          collectionId: CREDS.PRODUCT_FEATURES_COLLECTION_ID,
          queries: [
            client_sdk.Query.equal('product_id', productId),
            client_sdk.Query.orderAsc('sort'),
          ]);

      final List<ProductFeature> list = res.documents.map((e) {
        return ProductFeature.fromJson(e.data);
      }).toList();

      return list;
    } catch (e) {
      rethrow;
    }
  }
}
