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
    icon: Icons.home,
  ),
  analystPage(
    name: 'Analyst Page',
    page: AnalystPage(),
    icon: Icons.analytics,
  ),
  // basePage(
  //     name: "Base Page",
  //     page: BasePage(),
  //     icon:
  //       Icons.badge_sharp,
  //     ),
  hrPage(
    name: 'HR Page',
    page: HRPage(),
    icon: Icons.person_2,
  ),
  productsPage(
    name: "Products Page",
    page: ProductsPage(),
    icon: Icons.production_quantity_limits,
  ),
  salesPage(
    name: "Sales Page",
    page: SalesPage(),
    icon: Icons.monetization_on,
  ),
  inventoryPage(
    name: "Inventory Page",
    page: InventoryPage(),
    icon: Icons.inventory,
  ),
  settingsPage(
    name: "Settings Page",
    page: SettingsPage(),
    icon: Icons.settings,
  );

  final Widget page;
  final String name;
  final IconData icon;

  const PageReference({
    required this.name,
    required this.page,
    required this.icon,
  });
}

class PageSelectorBuilder {
  PageSelectorBuilder() : pages = PageReference.values.map((e) => e).toList();
  final List<PageReference> pages;

  List<PageReference> rolesSelectorBuilder(List<UserRole> roles) {
    List<PageReference> list = [];
    roles.map((e) {
      switch (e) {
        case UserRole.admin:
          break;
        case UserRole.editor:
          list.add(PageReference.productsPage);
          break;
        case UserRole.analyst:
          list.add(PageReference.analystPage);
          break;
        case UserRole.hr:
          list.add(PageReference.hrPage);
          break;
        case UserRole.sales:
          list.add(PageReference.salesPage);
          break;
        case UserRole.inventory:
          list.add(PageReference.inventoryPage);
          break;
        case UserRole.unknown:
          break;
      }
    }).toList();
    return list;
  }

  List<PageReference> selectorBuilder(
      UserRole role, List<UserRole> otherRoles) {
    List<PageReference> newPages = [];
    switch (role) {
      case UserRole.admin:
        return pages;
      case UserRole.editor:
        newPages = pages.where((e) {
          return e.name == "Products Page" || e.name == "Settings Page";
        }).toList();

        // newPages.addAll(rolesSelectorBuilder(otherRoles));
        break;
      // return newPages;
      case UserRole.analyst:
        newPages = pages.where((e) {
          return e.name == "Analyst Page" || e.name == "Settings Page";
        }).toList();

        // newPages.addAll(rolesSelectorBuilder(otherRoles));
        break;
      // return newPages;
      case UserRole.hr:
        newPages = pages.where((e) {
          return e.name == "HR Page" || e.name == "Settings Page";
        }).toList();

        // newPages.addAll(rolesSelectorBuilder(otherRoles));
        break;
      // return newPages;
      case UserRole.sales:
        newPages = pages.where((e) {
          return e.name == "Sales Page" || e.name == "Settings Page";
        }).toList();

        // newPages.addAll(rolesSelectorBuilder(otherRoles));
        break;
      // return newPages;
      case UserRole.inventory:
        newPages = pages.where((e) {
          return e.name == "Inventory Page" || e.name == "Settings Page";
        }).toList();

        // newPages.addAll(rolesSelectorBuilder(otherRoles));
        break;
      // return newPages;
      case UserRole.unknown:
        newPages = pages.where((e) {
          return e.name == "Settings Page";
        }).toList();

        // newPages.addAll(rolesSelectorBuilder(otherRoles));
        break;
      // return newPages;
    }
    newPages.addAll(rolesSelectorBuilder(otherRoles));
    newPages.sort((refa, refb) {
      return refa.name == "Settings Page" ? 1 : 0;
    });
    return newPages;
  }
}
