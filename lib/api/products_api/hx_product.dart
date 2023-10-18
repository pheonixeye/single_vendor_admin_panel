import 'package:appwrite/appwrite.dart' as client_sdk;

import 'package:single_vendor_admin_panel/api/constants/servers.dart';
import 'package:single_vendor_admin_panel/api/products_api/hx_product_images.dart';
import 'package:single_vendor_admin_panel/constants/creds.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';
import 'package:single_vendor_admin_panel/models/text_field_enums.dart';
import 'package:uuid/uuid.dart';

class HxProduct {
  final Server server;
  late final client_sdk.Databases db;
  late final HxProductImages imagesService;

  HxProduct({required this.server}) {
    db = client_sdk.Databases(server.clientClient);
    imagesService = HxProductImages(server: server);
  }
  Future<Product?> createProduct(Product product) async {
    try {
      final newProduct = product.coptWith(productId: const Uuid().v4());
      final res = await db.createDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_COLLECTION_ID,
        documentId: newProduct.productId,
        data: newProduct.toJson(),
      );

      final addedProduct = Product.fromJson(res.data);

      ///create db reference for adding images of a newly created product
      await imagesService.createProductImagesReference(addedProduct.productId);

      return addedProduct;
    } catch (e) {
      rethrow;
    }
  }

  Future<Product?> updateProduct(Product update) async {
    try {
      final res = await db.updateDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_COLLECTION_ID,
        documentId: update.productId,
        data: update.toJson(),
      );
      final updatedProduct = Product.fromJson(res.data);
      return updatedProduct;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteProduct(Product product) async {
    try {
      final res = await db.deleteDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_COLLECTION_ID,
        documentId: product.productId,
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<Product?> getProduct(Product product) async {
    try {
      final res = await db.getDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_COLLECTION_ID,
        documentId: product.productId,
      );
      final fetchedProduct = Product.fromJson(res.data);
      return fetchedProduct;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>?> listProducts() async {
    //TODO: implement pagination
    try {
      final res = await db.listDocuments(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_COLLECTION_ID,
      );
      final products = Product.productListFromJson(
          res.documents.map((e) => e.data).toList());
      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>?> searchProducts(String query, FieldLang lang) async {
    try {
      final res = await db.listDocuments(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_COLLECTION_ID,
        queries: switch (lang) {
          FieldLang.en => [
              client_sdk.Query.search('name_en', query),
            ],
          FieldLang.ar => [
              client_sdk.Query.search('name_ar', query),
            ],
        },
      );
      final products = Product.productListFromJson(
          res.documents.map((e) => e.data).toList());
      return products;
    } catch (e) {
      rethrow;
    }
  }
}
