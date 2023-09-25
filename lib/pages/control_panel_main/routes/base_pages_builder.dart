import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/admin_panel_page/admin_panel_page.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/analyst_page/analyst_page.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/base_page/base_page.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/hr_page/hr_page.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/products_page.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/settings_page/settings_page.dart';

export 'package:single_vendor_admin_panel/pages/control_panel_main/routes/admin_panel_page/admin_panel_page.dart';
export 'package:single_vendor_admin_panel/pages/control_panel_main/routes/analyst_page/analyst_page.dart';
export 'package:single_vendor_admin_panel/pages/control_panel_main/routes/base_page/base_page.dart';
export 'package:single_vendor_admin_panel/pages/control_panel_main/routes/hr_page/hr_page.dart';
export 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/products_page.dart';
export 'package:single_vendor_admin_panel/pages/control_panel_main/routes/settings_page/settings_page.dart';

enum PageBuilder {
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
  basePage(
      name: "Base Page",
      page: BasePage(),
      icon: Icon(
        Icons.badge_sharp,
      )),
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
  settingsPage(
    name: "Settings Page",
    page: SettingsPage(),
    icon: Icon(Icons.settings),
  );

  final Widget page;
  final String name;
  final Icon icon;

  const PageBuilder({
    required this.name,
    required this.page,
    required this.icon,
  });
}
