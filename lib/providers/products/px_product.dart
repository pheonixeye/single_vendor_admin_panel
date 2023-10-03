import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/api/products_api/hx_product.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';

class PxProduct extends ChangeNotifier {
  Product _product = Product.initial();

  PxProduct({required this.productService});
  Product get product => _product;

  final HxProduct productService;

  void initProduct() {
    _product = Product.initial();
    notifyListeners();
  }

  void selectProduct(Product value) {
    _product = value;
    notifyListeners();
  }

  void setOrUpdateProduct({
    String? nameEn,
    String? nameAr,
    String? descriptionEn,
    String? descriptionAr,
    String? productId,
  }) {
    _product = _product.coptWith(
      nameEn: nameEn,
      nameAr: nameAr,
      descriptionEn: descriptionEn,
      descriptionAr: descriptionAr,
      productId: productId,
    );
    notifyListeners();
  }

  Future<Product?> createProduct() async {
    try {
      final prod = await productService.createProduct(product);
      _product = prod!;
      notifyListeners();
      return _product;
    } catch (e) {
      rethrow;
    }
  }
}
