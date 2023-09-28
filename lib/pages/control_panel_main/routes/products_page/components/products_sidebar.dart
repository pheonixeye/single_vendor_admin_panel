import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/product_page_builder.dart';
import 'package:single_vendor_admin_panel/providers/products/px_products_nav.dart';
import 'package:single_vendor_admin_panel/theme/theme.dart';

class ProductsSidebar extends StatefulWidget {
  const ProductsSidebar({super.key});

  @override
  State<ProductsSidebar> createState() => _ProductsSidebarState();
}

class _ProductsSidebarState extends State<ProductsSidebar> {
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
                  'Products Panel',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                )
              : const CircleAvatar(
                  child: Icon(
                    Icons.production_quantity_limits,
                    size: 32,
                  ),
                ),
        );
      },
      items: [
        ...ProductsPageReference.values.map((e) {
          return SidebarXItem(
            iconWidget: Tooltip(
              message: e.name,
              child: Icon(e.icon),
            ),
            label: e.name,
            onTap: () {
              final index = ProductsPageReference.values.indexOf(e);
              _xController.selectIndex(index);
              context.read<PxProductsNavigation>().navigate(index);
            },
          );
        }).toList(),
      ],
    );
  }
}
