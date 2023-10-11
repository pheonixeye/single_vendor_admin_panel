import 'package:appwrite/appwrite.dart' as client_sdk;
import 'package:single_vendor_admin_panel/api/constants/servers.dart';
import 'package:single_vendor_admin_panel/constants/creds.dart';
import 'package:single_vendor_admin_panel/models/category_to_product.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';
import 'package:uuid/uuid.dart';

class HxProductCategory {
  final Server server;

  HxProductCategory({required this.server});

  // Future<ProductCategory?> getOneCategory(String categoryId) async {}

  Future<List<ProductCategory>?> listCategories() async {
    try {
      final db = client_sdk.Databases(server.clientClient);
      final doc = await db.listDocuments(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_CATEGORY_COLLECTION_ID,
      );
      List<Map<String, dynamic>> temp =
          doc.documents.map((e) => e.data).toList();
      List<ProductCategory> cats = ProductCategory.list(temp);
      return cats;
    } catch (e) {
      rethrow;
    }
  }

  ///set category Id only when creating one
  Future<ProductCategory?> createCategory(ProductCategory category) async {
    try {
      final db = client_sdk.Databases(server.clientClient);

      category = category.copyWith(
        categoryId: const Uuid().v4(),
      );

      final doc = await db.createDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_CATEGORY_COLLECTION_ID,
        documentId: category.categoryId,
        data: category.toJson(),
      );
      final cat = ProductCategory.fromJson(doc.data);

      final newCTP = CatToProd(
        nameEn: cat.nameEn,
        nameAr: cat.nameAr,
        categoryId: cat.categoryId,
        products: const [],
      );

      ///todo:create a ref to category in category_to_products collection
      await db.createDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.CAT_PRODS_COLLECTION_ID,
        documentId: cat.categoryId,
        data: newCTP.toJson(),
      );
      return cat;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteCategory(String categoryId) async {
    try {
      final db = client_sdk.Databases(server.clientClient);
      final res = await db.deleteDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_CATEGORY_COLLECTION_ID,
        documentId: categoryId,
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductCategory?> updateCategory(ProductCategory newCategory) async {
    try {
      final db = client_sdk.Databases(server.clientClient);
      final res = await db.updateDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_CATEGORY_COLLECTION_ID,
        documentId: newCategory.categoryId,
        data: newCategory.toJson(),
      );
      final cat = ProductCategory.fromJson(res.data);
      return cat;
    } catch (e) {
      rethrow;
    }
  }
}
