import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/fearures_edit/routes/feature_create.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/fearures_edit/routes/feature_list.dart';
import 'package:single_vendor_admin_panel/theme/theme.dart';

class FeaturesEditComponent extends StatefulWidget {
  const FeaturesEditComponent({super.key});

  @override
  State<FeaturesEditComponent> createState() => _FeaturesEditComponentState();
}

class _FeaturesEditComponentState extends State<FeaturesEditComponent> {
  late final SidebarXController _xController;

  @override
  void initState() {
    _xController = SidebarXController(
      selectedIndex: 0,
      extended: false,
    );
    super.initState();
  }

  final List<Widget> _pages = const [
    FeatureCreatePage(),
    FeatureListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SidebarX(
          controller: _xController,
          theme: sidebarXthemeRegularDark,
          extendedTheme: sidebarXthemeExtendedDark,
          items: [
            SidebarXItem(
              label: "Create Feature",
              iconWidget: const Icon(Icons.create_new_folder),
              onTap: () {
                setState(() {
                  _xController.selectIndex(0);
                });
              },
            ),
            SidebarXItem(
              label: "Edit Feature",
              iconWidget: const Icon(Icons.edit_document),
              onTap: () {
                setState(() {
                  _xController.selectIndex(1);
                });
              },
            ),
          ],
        ),
        Expanded(
          child: _pages[_xController.selectedIndex],
        ),
      ],
    );
  }
}
