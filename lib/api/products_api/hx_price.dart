import 'package:appwrite/appwrite.dart' as client_sdk;
import 'package:single_vendor_admin_panel/api/constants/servers.dart';
import 'package:single_vendor_admin_panel/constants/creds.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';

class HxPrice {
  final Server server;
  late final client_sdk.Databases db;

  HxPrice({required this.server}) {
    db = client_sdk.Databases(server.clientClient);
  }

  Future<ProductPrice?> createPrice(ProductPrice price) async {
    try {
      final res = await db.createDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_PRICE_COLLECTION_ID,
        documentId: price.productId,
        data: price.toJson(),
      );

      final ProductPrice newPrice = ProductPrice.fromJson(res.data);

      return newPrice;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductPrice?> updatePrice(ProductPrice price) async {
    try {
      final res = await db.updateDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_PRICE_COLLECTION_ID,
        documentId: price.productId,
        data: price.toJson(),
      );

      final ProductPrice newPrice = ProductPrice.fromJson(res.data);

      return newPrice;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductPrice?> getPrice(String productId) async {
    try {
      final res = await db.getDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_PRICE_COLLECTION_ID,
        documentId: productId,
      );
      // print(res.data);
      final ProductPrice newPrice = ProductPrice.fromJson(res.data);

      return newPrice;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductPrice>?> listPrices() async {
    try {
      final res = await db.listDocuments(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_PRICE_COLLECTION_ID,
      );

      final List<ProductPrice> prices = res.documents.map((e) {
        return ProductPrice.fromJson(e.data);
      }).toList();

      return prices;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deletePrice(ProductPrice price) async {
    try {
      final res = await db.deleteDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_PRICE_COLLECTION_ID,
        documentId: price.productId,
      );

      return res;
    } catch (e) {
      rethrow;
    }
  }
}
