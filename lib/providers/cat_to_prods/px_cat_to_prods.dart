import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/api/category_to_product/hx_cat_prod.dart';
import 'package:single_vendor_admin_panel/models/category_to_product.dart';

class PxCategoryToProducts extends ChangeNotifier {
  PxCategoryToProducts({required this.ctpService}) {
    listCTP();
  }

  CatToProd _ctp = CatToProd.initial();
  CatToProd get ctp => _ctp;

  List<CatToProd> _ctpList = [];
  List<CatToProd> get ctpList => _ctpList;

  final HxCatToProd ctpService;

  void selectCTP(CatToProd value) {
    _ctp = value;
    notifyListeners();
  }

  void initCTP() {
    _ctp = CatToProd.initial();
    notifyListeners();
  }

  Future<void> listCTP() async {
    try {
      final list = await ctpService.listCatToProd();
      _ctpList = list!;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(String newProduct) async {
    _ctp = _ctp.addProduct(
      newProduct: newProduct,
    );
    await updateCTP();
  }

  Future<void> removeProduct(String product) async {
    _ctp = _ctp.removeProduct(
      product: product,
    );
    await updateCTP();
  }

  Future<void> updateCTP() async {
    try {
      final cTp = await ctpService.updateCTP(_ctp);
      _ctp = cTp!;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
