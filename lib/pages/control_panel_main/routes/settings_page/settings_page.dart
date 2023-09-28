import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/api/products_api/hx_product_unit.dart';
import 'package:single_vendor_admin_panel/providers/px_localization.dart';
import 'package:single_vendor_admin_panel/providers/px_server_status_px.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  _switchLanguage(BuildContext context) {
    final location =
        GoRouter.of(context).routeInformationProvider.value.uri.path;
    final paths = location.split(RegExp('/'));
    paths.removeAt(0);
    paths.removeAt(0);
    final whereToGo = paths.join('/');
    if (context.read<PxLocalization>().locale.languageCode == 'en') {
      GoRouter.of(context).go('/ar/$whereToGo');
    } else {
      GoRouter.of(context).go('/en/$whereToGo');
    }
  }

  late final HxProductUnit productsService;

  String? _products;

  @override
  void initState() {
    productsService =
        HxProductUnit(server: context.read<PxServerStatus>().server!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: theme
    //TODO: language
    //TODO: find other settings
    return Scaffold(
      backgroundColor: Colors.pink,
      floatingActionButton: FloatingActionButton(
        heroTag: "lang-btn",
        onPressed: () {
          _switchLanguage(context);
        },
        child: Text(context.watch<PxLocalization>().locale.languageCode),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final data = await productsService.fetchProducts();
                  setState(() {
                    _products = data;
                  });
                },
                child: const Text('Fetch Products'),
              ),
              Expanded(
                child: _products == null
                    ? const Text("No Products...")
                    : SelectableText(
                        _products!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
