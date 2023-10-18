import 'package:appwrite/appwrite.dart' as client_sdk;
import 'package:single_vendor_admin_panel/api/constants/servers.dart';
import 'package:single_vendor_admin_panel/constants/creds.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';

class HxProductImages {
  final Server server;
  late final client_sdk.Databases db;
  late final client_sdk.Storage storage;

  HxProductImages({required this.server}) {
    db = client_sdk.Databases(server.clientClient);
    storage = client_sdk.Storage(server.clientClient);
  }

  ///for use when creating a product for the first time
  ///HxProduct
  Future<ProductImages?> createProductImagesReference(String productId) async {
    try {
      final result = await db.createDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_IMAGES_COLLECTION_ID,
        documentId: productId,
        data: ProductImages(
          productId: productId,
          images: const [],
        ).toJson(),
      );
      final productImages = ProductImages.fromJson(result.data);

      return productImages;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _addProductImageToBucket(String filePath) async {
    try {
      final result = await storage.createFile(
        bucketId: CREDS.PRODUCT_IMAGES_BUCKET_ID,
        fileId: client_sdk.ID.unique(),
        file: client_sdk.InputFile.fromPath(
          path: filePath,
        ),
      );

      return result.$id;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductImages?> addProductImageToDb(
    ProductImages images,
    String filePath,
  ) async {
    try {
      final newFileId = await _addProductImageToBucket(filePath);

      images = images.addImage(newFileId);

      final result = await db.updateDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_IMAGES_COLLECTION_ID,
        documentId: images.productId,
        data: images.toJson(),
      );

      final newImages = ProductImages.fromJson(result.data);

      return newImages;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _deleteProductImageFromBucket(String fileId) async {
    try {
      await storage.deleteFile(
        bucketId: CREDS.PRODUCT_IMAGES_BUCKET_ID,
        fileId: fileId,
      );

      return fileId;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteProductImageFromDb(
    ProductImages images,
    String fileId,
  ) async {
    try {
      final newFileId = await _deleteProductImageFromBucket(fileId);

      images = images.removeImage(newFileId);

      final result = await db.updateDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_IMAGES_COLLECTION_ID,
        documentId: images.productId,
        data: images.toJson(),
      );

      final newImages = ProductImages.fromJson(result.data);

      return newImages;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductImages?> getProductImages(String productId) async {
    try {
      final result = await db.getDocument(
        databaseId: CREDS.DATABASE_ID,
        collectionId: CREDS.PRODUCT_IMAGES_COLLECTION_ID,
        documentId: productId,
      );

      final images = ProductImages.fromJson(result.data);
      return images;
    } catch (e) {
      rethrow;
    }
  }
}
