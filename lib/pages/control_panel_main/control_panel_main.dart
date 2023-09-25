import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:single_vendor_admin_panel/components/main_dialog.dart';
import 'package:single_vendor_admin_panel/components/main_snackbar.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/base_pages_builder.dart';
import 'package:single_vendor_admin_panel/providers/auth/px_app_users.dart';
import 'package:single_vendor_admin_panel/providers/px_localization.dart';
import 'package:single_vendor_admin_panel/routes/routes.dart';

class ControlPanelMain extends StatefulWidget {
  const ControlPanelMain({super.key});

  @override
  State<ControlPanelMain> createState() => _ControlPanelMainState();
}

class _ControlPanelMainState extends State<ControlPanelMain>
    with AfterLayoutMixin {
  late final SidebarXController _controller;
  late final PageController _pageController;

  // static const List<Widget> _pages = [
  //   BasePage(),
  //   AdminPanelPage(),
  //   AnalystPage(),
  //   HRPage(),
  //   ProductsPage(),
  //   SettingsPage(),
  // ];

  Widget buildPage(int index) {
    return PageBuilder.values[index].page;
  }

  List<SidebarXItem> footerItems() => [
        SidebarXItem(
          label: "Log Out",
          iconWidget: const Icon(Icons.logout),
          onTap: () async {
            try {
              await EasyLoading.show(status: "LOADING...");
              if (mounted) {
                await context.read<PxAppUsers>().clearLoginSessions();
              }
              await EasyLoading.dismiss();
              if (mounted) {
                showInfoSnackbar(context, 'Logged Out');
                GoRouter.of(context)
                    .goNamed(PageDir.auth_page.name, pathParameters: {
                  'lang': context.read<PxLocalization>().locale.languageCode,
                });
              }
            } catch (e) {
              await EasyLoading.dismiss();
              if (mounted) {
                showInfoSnackbar(context, 'Log Out Failed...', Colors.red);
              }
            }
          },
        ),
        SidebarXItem(
          label: "About",
          iconWidget: const Icon(Icons.info),
          onTap: () async {
            await showMainDialog(context);
            setState(() {
              _controller.selectIndex(0);
              _controller.setExtended(false);
            });
          },
        ),
      ];

  List<SidebarXItem> menuItems(SidebarXController controller) => [
        ...PageBuilder.values.map((e) {
          return SidebarXItem(
            label: e.name,
            iconWidget: e.icon,
            onTap: () {
              setState(() {
                // controller.selectIndex(PageBuilder.values.indexOf(e));
                _pageController.animateToPage(PageBuilder.values.indexOf(e),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
                controller.setExtended(false);
              });
            },
          );
        }).toList(),
      ];

  @override
  void initState() {
    super.initState();
    _controller = SidebarXController(
      selectedIndex: 0,
      extended: true,
    );
    _pageController = PageController(
      initialPage: _controller.selectedIndex,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await context.read<PxAppUsers>().fetchLoggedInUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidebarX(
            controller: _controller,
            items: menuItems(_controller),
            theme: const SidebarXTheme(
              width: 70,
              iconTheme: IconThemeData(),
              selectedIconTheme: IconThemeData(
                size: 42,
                color: Colors.blue,
              ),
            ),
            extendedTheme: SidebarXTheme(
              width: 250,
              hoverColor: Colors.orange.shade200,
              itemTextPadding: const EdgeInsets.all(8),
              selectedItemTextPadding: const EdgeInsets.all(12),
              selectedIconTheme: const IconThemeData(
                size: 42,
                color: Colors.blue,
              ),
              selectedTextStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              selectedItemDecoration: BoxDecoration(
                color: Colors.amber,
                border: Border.all(),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            headerBuilder: (context, extended) {
              return Consumer<PxAppUsers>(
                builder: (context, u, c) {
                  while (u.appUser == null) {
                    return const Text(
                      "Loading...",
                      textAlign: TextAlign.center,
                    );
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _controller.extended
                          ? ListTile(
                              title: const Text("User"),
                              subtitle: Text(
                                u.appUser!.email == ''
                                    ? "Anonymous User"
                                    : u.appUser!.email,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : const Icon(
                              Icons.person,
                              size: 42,
                            ),
                      _controller.extended
                          ? ListTile(
                              title: const Text("Role"),
                              subtitle: Text(
                                u.appUser!.role.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : const Icon(
                              Icons.roller_shades,
                              size: 42,
                            ),
                    ],
                  );
                },
              );
            },
            headerDivider: Divider(
              height: 4,
              color: Colors.indigo.shade900,
            ),
            footerDivider: Divider(
              height: 4,
              color: Colors.indigo.shade900,
            ),
            separatorBuilder: (context, index) {
              return const Divider();
            },
            footerItems: footerItems(),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: PageBuilder.values.length,
              itemBuilder: (context, index) {
                return buildPage(_controller.selectedIndex);
              },
            ),
          )
        ],
      ),
    );
  }
}
