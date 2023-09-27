import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/hr_page/hr_pages_builder.dart';
import 'package:single_vendor_admin_panel/providers/hr/px_hr_navigation.dart';
import 'package:single_vendor_admin_panel/theme/theme.dart';

class HrPageSideBar extends StatefulWidget {
  const HrPageSideBar({super.key});

  @override
  State<HrPageSideBar> createState() => _HrPageSideBarState();
}

class _HrPageSideBarState extends State<HrPageSideBar> {
  late final SidebarXController _xController;

  @override
  void initState() {
    _xController = SidebarXController(
      selectedIndex: 0,
      extended: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _xController,
      theme: sidebarXthemeRegularDark,
      extendedTheme: sidebarXthemeExtendedDark,
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: _xController.extended
              ? const Text(
                  'Human Resources',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                )
              : const CircleAvatar(
                  child: Icon(
                    Icons.person_2,
                    size: 32,
                  ),
                ),
        );
      },
      items: [
        ...HRPageReference.values.map((e) {
          return SidebarXItem(
            icon: e.icon,
            label: e.name,
            onTap: () {
              final index = HRPageReference.values.indexOf(e);
              _xController.selectIndex(index);
              context.read<PxHRnavigation>().navigate(index);
            },
          );
        }).toList(),
      ],
    );
  }
}
