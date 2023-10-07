import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/api/products_api/hx_price.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';

class PxProductPrice extends ChangeNotifier {
  ProductPrice _price = ProductPrice.initial();

  PxProductPrice({required this.priceService});
  ProductPrice get price => _price;

  final HxPrice priceService;

  void setOrUpdatePrice({
    String? productId,
    double? price,
    double? discount,
  }) {
    _price = _price.copyWith(
      price: price,
      productId: productId,
      discount: discount,
    );
    notifyListeners();
  }

  void selectPrice(ProductPrice newPrice) {
    _price = newPrice;
    notifyListeners();
  }

  void initPrice() {
    _price = ProductPrice.initial();
    notifyListeners();
  }

  Future<ProductPrice?> createPrice() async {
    try {
      final p = await priceService.createPrice(price);
      _price = p!;
      notifyListeners();
      return _price;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductPrice?> getPrice(String productId) async {
    try {
      final p = await priceService.getPrice(productId);
      _price = p!;
      notifyListeners();
      return _price;
    } catch (e) {
      _price = ProductPrice.initial();
      notifyListeners();
      return _price;
    }
  }

  Future<ProductPrice?> updatePrice() async {
    try {
      final p = await priceService.updatePrice(price);
      _price = p!;
      notifyListeners();
      return _price;
    } catch (e) {
      rethrow;
    }
  }
}
