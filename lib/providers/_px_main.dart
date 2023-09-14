import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:single_vendor_admin_panel/providers/px_localization.dart';
import 'package:single_vendor_admin_panel/providers/server_status_px.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => PxServerStatus()),
  ChangeNotifierProvider(create: (context) => PxLocalization()),
];
