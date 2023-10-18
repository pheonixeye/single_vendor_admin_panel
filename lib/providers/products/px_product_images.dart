import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/api/products_api/hx_product_images.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';

class PxProductImages extends ChangeNotifier {
  final HxProductImages imagesService;

  PxProductImages({required this.imagesService});

  ProductImages _images = ProductImages.initial();
  ProductImages get images => _images;

  void selectImages(ProductImages value) {
    _images = value;
    notifyListeners();
  }

  void initImages() {
    _images = ProductImages.initial();
    notifyListeners();
  }

  Future<ProductImages> getProductImages() async {
    try {
      final res = await imagesService.getProductImages(_images.productId);
      _images = res!;
      notifyListeners();
      return _images;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductImages> addProductImage(String filePath) async {
    try {
      await imagesService.addProductImageToDb(images, filePath);
      return await getProductImages();
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductImages> deleteProductImage(String fileId) async {
    try {
      await imagesService.deleteProductImageFromDb(images, fileId);
      return await getProductImages();
    } catch (e) {
      rethrow;
    }
  }
}
