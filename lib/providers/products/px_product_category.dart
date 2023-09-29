import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/api/errors/general_exception.dart';
import 'package:single_vendor_admin_panel/api/products_api/hx_product_category.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';

class PxProductCategory extends ChangeNotifier {
  PxProductCategory({required this.categoryService});
  final HxProductCategory categoryService;

  ProductCategory _category = ProductCategory.initial();
  ProductCategory get category => _category;

  List<ProductCategory> _categories = [];
  List<ProductCategory> get categories => _categories;

  void setOrUpdateCategory({
    String? nameEn,
    String? nameAr,
    String? descriptionEn,
    String? descriptionAr,
    String? categoryId,
  }) {
    _category = _category.copyWith(
      nameEn: nameEn ?? _category.nameEn,
      nameAr: nameAr ?? _category.nameAr,
      descriptionEn: descriptionEn ?? _category.descriptionEn,
      descriptionAr: descriptionAr ?? _category.descriptionAr,
      categoryId: categoryId ?? _category.categoryId,
    );
    notifyListeners();
  }

  void selectCategory(ProductCategory newCat) {
    _category = newCat;
    notifyListeners();
  }

  void resetCategory() {
    _category = ProductCategory.initial();
    // print("category reset...");
  }

  void addCategoryToList(ProductCategory cat) {
    _categories.add(cat);
    notifyListeners();
  }

  void removeCategoryFromList(String categoryId) {
    _categories.removeWhere((element) => element.categoryId == categoryId);
    notifyListeners();
  }

  void updateCategoryInList(ProductCategory newCat) {
    final int index = _categories
        .indexWhere((element) => element.categoryId == newCat.categoryId);
    _categories.removeAt(index);
    _categories.insert(index, newCat);
    notifyListeners();
  }

  Future<ProductCategory> createCategory() async {
    if (category.nameAr.isEmpty || category.nameEn.isEmpty) {
      throw GeneralException(
        message: "Empty Category Name EN/AR Fields...Kindly Try Again Later...",
      );
    }
    try {
      final cat = await categoryService.createCategory(category);
      _category = cat!;
      addCategoryToList(_category);
      notifyListeners();
      return _category;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductCategory>> listProductCategories() async {
    try {
      final _list = await categoryService.listCategories();
      _categories = _list!;
      notifyListeners();
      return _categories;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteProductCategory(String categoryId) async {
    try {
      await categoryService.deleteCategory(categoryId);
      removeCategoryFromList(categoryId);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateProductCategory() async {
    try {
      final newCat = await categoryService.updateCategory(category);
      updateCategoryInList(newCat!);
    } catch (e) {
      rethrow;
    }
  }
}
