import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/categories/components/create_cat_page.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/categories/components/edit_cat_page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int _currentIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
            _pageController.animateToPage(
              _currentIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          });
        },
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        //TODO: save this color
        backgroundColor: const Color(0xffEBE4F2),
        selectedIconTheme: IconThemeData(
          size: 42,
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0,
        useLegacyColorScheme: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: "Create",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: "Edit",
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: const [
          CreateCategoryPage(),
          EditCategoryPage(),
        ],
      ),
    );
  }
}
