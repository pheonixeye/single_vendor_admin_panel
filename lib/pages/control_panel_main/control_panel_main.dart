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
    with AfterLayoutMixin, SingleTickerProviderStateMixin {
  late final SidebarXController _controller;
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  List<SidebarXItem> _items = [];
  final _pageBuilderPages = PageSelectorBuilder();

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
              if (_controller.extended) {
                _controller.setExtended(false);
              }
            });
          },
        ),
      ];

  List<SidebarXItem> menuItems() => [
        ..._pageBuilderPages
            .selectorBuilder(context.read<PxAppUsers>().loggedInAppUser!.role)
            .map((e) {
          return SidebarXItem(
            label: e.name,
            iconWidget: e.icon,
            onTap: () {
              setState(() {
                if (!_animationController.isCompleted) {
                  _animationController.forward();
                } else {
                  _animationController.reset();
                  _animationController.forward();
                }
                _controller.selectIndex(PageReference.values.indexOf(e));
                if (_controller.extended) {
                  _controller.setExtended(false);
                }
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
      extended: false,
    );
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      upperBound: 1.0,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = Animation.fromValueListenable(_animationController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await context.read<PxAppUsers>().fetchLoggedInUser().then((_) {
      setState(() {
        _items = menuItems();
      });
    });
    _animationController.forward();
    print('loggedin: ${context.read<PxAppUsers>().loggedInAppUser!.toJson()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidebarX(
            controller: _controller,
            items: _items,
            theme: SidebarXTheme(
              width: 70,
              iconTheme: const IconThemeData(),
              selectedIconTheme: const IconThemeData(
                size: 42,
                color: Colors.blue,
              ),
              selectedItemDecoration: BoxDecoration(
                color: Colors.amber,
                border: Border.all(
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            extendedTheme: SidebarXTheme(
              width: 250,
              hoverColor: Colors.orange.shade200,
              itemPadding: const EdgeInsets.all(4),
              selectedItemTextPadding:
                  const EdgeInsets.symmetric(horizontal: 12),
              selectedTextStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              selectedItemDecoration: BoxDecoration(
                color: Colors.amber,
                border: Border.all(
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
                border: Border.all(
                  color: Colors.grey,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: const Offset(3, 3),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 2,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            headerBuilder: (context, extended) {
              return Consumer<PxAppUsers>(
                builder: (context, u, c) {
                  while (u.loggedInAppUser == null) {
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
                                u.loggedInAppUser!.email == ''
                                    ? "Anonymous User"
                                    : u.loggedInAppUser!.email,
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
                                u.loggedInAppUser!.role.name,
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
            child: AnimatedBuilder(
              animation: _animationController,
              child: _pageBuilderPages
                  .selectorBuilder(context
                      .read<PxAppUsers>()
                      .loggedInAppUser!
                      .role)[_controller.selectedIndex]
                  .page,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _animation,
                  child: child,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
