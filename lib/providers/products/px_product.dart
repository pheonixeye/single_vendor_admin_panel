import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/api/products_api/hx_product.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product_list.dart';

class PxProduct extends ChangeNotifier {
  Product _product = Product.initial();
  Product get product => _product;

  PxProduct({required this.productService, required this.context});

  final HxProduct productService;
  final BuildContext context;

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
      if (context.mounted) {
        await context.read<PxProductList>().listProducts();
      }
      return _product;
    } catch (e) {
      rethrow;
    }
  }

  Future<Product?> updateProduct() async {
    try {
      final update = await productService.updateProduct(product);
      _product = update!;
      notifyListeners();
      if (context.mounted) {
        await context.read<PxProductList>().listProducts();
      }
      return _product;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteProduct(Product prod) async {
    try {
      final res = await productService.deleteProduct(prod);
      if (context.mounted) {
        await context.read<PxProductList>().listProducts();
      }
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
