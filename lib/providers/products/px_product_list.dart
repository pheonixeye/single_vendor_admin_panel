import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/api/products_api/hx_product.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';
import 'package:single_vendor_admin_panel/models/text_field_enums.dart';

class PxProductList extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  PxProductList({required this.productService}) {
    listProducts();
  }

  final HxProduct productService;

  void clearProduct() {
    _products = [];
    notifyListeners();
  }

  Future<List<Product>>? listProducts() async {
    //TODO: implement pagination
    try {
      final list = await productService.listProducts();
      _products = list!;
      _filteredProducts = list;
      notifyListeners();
      return _products;
    } catch (e) {
      rethrow;
    }
  }

  List<Product> _filteredProducts = [];
  List<Product> get filteredProducts => _filteredProducts;

  Future<List<Product>>? filterProducts(String value, FieldLang lang) async {
    try {
      final filtered = await productService.searchProducts(value, lang);
      _filteredProducts = filtered!;
      notifyListeners();
      return _filteredProducts;
    } catch (e) {
      rethrow;
    }
  }

  void resetFilter() {
    _filteredProducts = _products;
    notifyListeners();
  }
}
