import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:single_vendor_admin_panel/api/appusers/hx_appusers.dart';
import 'package:single_vendor_admin_panel/api/products_api/hx_product_unit.dart';
import 'package:single_vendor_admin_panel/providers/auth/px_app_users.dart';
import 'package:single_vendor_admin_panel/providers/products/px_products.dart';
import 'package:single_vendor_admin_panel/providers/px_localization.dart';
import 'package:single_vendor_admin_panel/providers/px_server_status_px.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => PxServerStatus()),
  ChangeNotifierProvider(create: (context) => PxLocalization()),
  ChangeNotifierProvider(
    create: (context) => PxAppUsers(
      usersService: HxAppUsers(
        server: context.read<PxServerStatus>().server!,
      ),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => PxProductUnit(
      productUnitService: HxProductUnit(
        server: context.read<PxServerStatus>().server!,
      ),
    ),
  ),
];
