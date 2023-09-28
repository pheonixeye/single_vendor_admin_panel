import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/api/products_api/hx_product_unit.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';
import 'package:uuid/uuid.dart';

class PxProductUnit extends ChangeNotifier {
  final HxProductUnit productUnitService;
  PxProductUnit({required this.productUnitService});

  ProductUnit _unit = ProductUnit.initial();
  ProductUnit get unit => _unit;

  List<ProductUnit> _units = [];
  List<ProductUnit> get units => _units;

  void setUnit({
    String? en,
    String? ar,
  }) {
    final id = const Uuid().v4();
    _unit = _unit.copyWith(
      nameEn: en,
      nameAr: ar,
      unitId: id,
    );
    notifyListeners();
  }

  void emptyUnit() {
    _unit = ProductUnit.initial();
    notifyListeners();
  }

  void setUnitList(List<ProductUnit> newUnits) {
    _units = newUnits;
    notifyListeners();
  }

  void emptyUnitList() {
    _units = [];
    notifyListeners();
  }

  Future<dynamic> fetchProductUnitList() async {
    try {
      final u = await productUnitService.listProductUnits();
      setUnitList(u);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createProductUnit() async {
    try {
      await productUnitService.createProductUnit(unit);
      await fetchProductUnitList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeProductUnit(String unitId) async {
    try {
      await productUnitService.deleteProductUnit(unitId);
      await fetchProductUnitList();
    } catch (e) {
      rethrow;
    }
  }
}
