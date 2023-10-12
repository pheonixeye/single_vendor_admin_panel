import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/api/products_api/hx_product_features.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';

class PxProductFeatures extends ChangeNotifier {
  PxProductFeatures({required this.featureService});

  ProductFeature _productFeature = ProductFeature.initial();
  ProductFeature get productFeature => _productFeature;

  final HxProductFeatures featureService;

  void initFeature() {
    _productFeature = ProductFeature.initial();
    notifyListeners();
  }

  void setOrUpdateFeature({
    String? id,
    int? sort,
    String? nameEn,
    String? nameAr,
    String? descriptionEn,
    String? descriptionAr,
    String? productId,
    bool? hasSpecialValue,
    SpecialValueType? specialValueType,
    int? specialValueInt,
    double? specialValueDouble,
    bool? specialValueBool,
  }) {
    _productFeature = _productFeature.copyWith(
      id: id ?? _productFeature.id,
      sort: sort ?? _productFeature.sort,
      nameEn: nameEn ?? _productFeature.nameEn,
      nameAr: nameAr ?? _productFeature.nameAr,
      descriptionEn: descriptionEn ?? _productFeature.descriptionEn,
      descriptionAr: descriptionAr ?? _productFeature.descriptionAr,
      productId: productId ?? _productFeature.productId,
      hasSpecialValue: hasSpecialValue ?? _productFeature.hasSpecialValue,
      specialValueType: specialValueType ?? _productFeature.specialValueType,
      specialValueInt: specialValueInt ?? _productFeature.specialValueInt,
      specialValueDouble:
          specialValueDouble ?? _productFeature.specialValueDouble,
      specialValueBool: specialValueBool ?? _productFeature.specialValueBool,
    );
    notifyListeners();
  }

  void selectFeature(ProductFeature feature) {
    _productFeature = feature;
    notifyListeners();
  }

  Future<ProductFeature> createFeature() async {
    try {
      final feat = await featureService.createFeature(productFeature);
      _productFeature = feat!;
      notifyListeners();
      return _productFeature;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductFeature> updateFeature() async {
    try {
      final feat = await featureService.updateFeature(productFeature);
      _productFeature = feat!;
      notifyListeners();
      return _productFeature;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteFeature() async {
    try {
      final feat = await featureService.deleteFeature(productFeature);
      return feat;
    } catch (e) {
      rethrow;
    }
  }

  List<ProductFeature> _features = [];
  List<ProductFeature> get features => _features;

  Future<List<ProductFeature>> listFeatures(String productId) async {
    try {
      final list = await featureService.listFeatures(productId);
      _features = list!;
      notifyListeners();
      return _features;
    } catch (e) {
      rethrow;
    }
  }
}
