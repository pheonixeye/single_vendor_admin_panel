import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:single_vendor_admin_panel/providers/auth/px_app_users.dart';
import 'package:single_vendor_admin_panel/providers/px_localization.dart';
import 'package:single_vendor_admin_panel/providers/px_server_status_px.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => PxServerStatus()),
  ChangeNotifierProvider(create: (context) => PxLocalization()),
  ChangeNotifierProvider(create: (context) => PxAppUsers()),
];
