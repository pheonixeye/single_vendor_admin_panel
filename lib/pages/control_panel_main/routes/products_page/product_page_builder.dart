import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/categories/categories_page.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/create_product/create_product_page.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/edit_product_page.dart';
// import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/search_product/search_product_page.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/units/units_page.dart';

enum ProductsPageReference {
  createProduct(
    name: "Create Product",
    icon: Icons.icecream,
    page: CreateProductPage(),
  ),
  editProduct(
    name: "Edit Product",
    icon: Icons.edit,
    page: EditProductPage(),
  ),
  // searchProduct(
  //   name: "Search Products",
  //   icon: Icons.search,
  //   page: SearchProductPage(),
  // ),
  productCategories(
    name: "Categories",
    icon: Icons.money,
    page: CategoriesPage(),
  ),
  productUnits(
    name: "Storage Units",
    icon: Icons.numbers,
    page: UnitsPage(),
  );

  final Widget page;
  final String name;
  final IconData icon;

  const ProductsPageReference({
    required this.name,
    required this.page,
    required this.icon,
  });
}
