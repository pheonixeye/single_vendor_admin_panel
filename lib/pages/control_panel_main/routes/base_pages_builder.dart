import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/models/app_user_model.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/admin_panel_page/admin_panel_page.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/analyst_page/analyst_page.dart';
// import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/base_page/base_page.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/hr_page/hr_page.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/inventory_page/inventory_page.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/products_page.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/sales_page/sales_page.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/settings_page/settings_page.dart';

export 'package:single_vendor_admin_panel/pages/control_panel_main/routes/admin_panel_page/admin_panel_page.dart';
export 'package:single_vendor_admin_panel/pages/control_panel_main/routes/analyst_page/analyst_page.dart';
export 'package:single_vendor_admin_panel/pages/control_panel_main/routes/base_page/base_page.dart';
export 'package:single_vendor_admin_panel/pages/control_panel_main/routes/hr_page/hr_page.dart';
export 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/products_page.dart';
export 'package:single_vendor_admin_panel/pages/control_panel_main/routes/settings_page/settings_page.dart';

enum PageReference {
  adminPanel(
    name: 'Admin Panel',
    page: AdminPanelPage(),
    icon: Icon(Icons.home),
  ),
  analystPage(
    name: 'Analyst Page',
    page: AnalystPage(),
    icon: Icon(Icons.analytics),
  ),
  // basePage(
  //     name: "Base Page",
  //     page: BasePage(),
  //     icon: Icon(
  //       Icons.badge_sharp,
  //     )),
  hrPage(
    name: 'HR Page',
    page: HRPage(),
    icon: Icon(Icons.person_2),
  ),
  productsPage(
    name: "Products Page",
    page: ProductsPage(),
    icon: Icon(Icons.production_quantity_limits),
  ),
  salesPage(
    name: "Sales Page",
    page: SalesPage(),
    icon: Icon(Icons.monetization_on),
  ),
  inventoryPage(
    name: "Inventory Page",
    page: InventoryPage(),
    icon: Icon(Icons.inventory),
  ),
  settingsPage(
    name: "Settings Page",
    page: SettingsPage(),
    icon: Icon(Icons.settings),
  );

  final Widget page;
  final String name;
  final Icon icon;

  const PageReference({
    required this.name,
    required this.page,
    required this.icon,
  });
}

class PageSelectorBuilder {
  PageSelectorBuilder() : pages = PageReference.values.map((e) => e).toList();
  final List<PageReference> pages;

  List<PageReference> selectorBuilder(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return pages;
      case UserRole.editor:
        final Iterable<PageReference> newPages = pages.where((e) {
          return e.name == "Products Page" || e.name == "Settings Page";
        });

        return newPages.toList();
      case UserRole.analyst:
        final Iterable<PageReference> newPages = pages.where((e) {
          return e.name == "Analyst Page" || e.name == "Settings Page";
        });

        return newPages.toList();
      case UserRole.hr:
        final Iterable<PageReference> newPages = pages.where((e) {
          return e.name == "HR Page" || e.name == "Settings Page";
        });

        return newPages.toList();
      case UserRole.sales:
        final Iterable<PageReference> newPages = pages.where((e) {
          return e.name == "Sales Page" || e.name == "Settings Page";
        });

        return newPages.toList();
      case UserRole.inventory:
        final Iterable<PageReference> newPages = pages.where((e) {
          return e.name == "Inventory Page" || e.name == "Settings Page";
        });

        return newPages.toList();
      case UserRole.unknown:
        final Iterable<PageReference> newPages = pages.where((e) {
          return e.name == "Settings Page";
        });

        return newPages.toList();
    }
  }
}
