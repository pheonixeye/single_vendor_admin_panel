import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/hr_page/components/hr_sidebar.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/hr_page/hr_pages_builder.dart';
import 'package:single_vendor_admin_panel/providers/hr/px_hr_navigation.dart';

class HRPage extends StatefulWidget {
  const HRPage({super.key});

  @override
  State<HRPage> createState() => _HRPageState();
}

class _HRPageState extends State<HRPage> {
  @override
  Widget build(BuildContext context) {
    //todo: create user
    //todo: assign user roles && delete / deactivate users
    //TODO: see user logs signin/signout times mainly ??
    //TODO: see customer user logs && separate customer users from app users
    //TODO: set salary calculations //!(deferred)
    return Scaffold(
      body: Card(
        child: ChangeNotifierProvider(
          create: (context) => PxHRnavigation(),
          builder: (context, child) {
            return Row(
              children: [
                const HrPageSideBar(),
                Consumer<PxHRnavigation>(
                  builder: (context, n, c) {
                    return Expanded(
                      child: HRPageReference.values[n.index].page,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
