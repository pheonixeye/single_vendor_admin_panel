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
import 'package:single_vendor_admin_panel/theme/theme.dart';

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
          // icon: Icons.logout,
          iconWidget: const Tooltip(
            message: "Log Out",
            child: Icon(
              Icons.logout,
            ),
          ),
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
                showInfoSnackbar(context, e.toString(), Colors.red);
              }
            }
          },
        ),
        SidebarXItem(
          label: "About",
          iconWidget: const Tooltip(
            message: "About",
            child: Icon(
              Icons.info,
            ),
          ),
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
            .selectorBuilder(
          context.read<PxAppUsers>().loggedInAppUser!.role,
          context.read<PxAppUsers>().loggedInAppUser!.otherRoles,
        )
            .map((e) {
          return SidebarXItem(
            label: e.name,
            iconWidget: Tooltip(
              message: e.name,
              child: Icon(e.icon),
            ),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidebarX(
            controller: _controller,
            items: _items,
            theme: sidebarXthemeRegularDark,
            extendedTheme: sidebarXthemeExtendedDark,
            headerBuilder: (context, extended) {
              return Consumer<PxAppUsers>(
                builder: (context, u, c) {
                  while (u.loggedInAppUser == null) {
                    return const Text(
                      "Loading...",
                      textAlign: TextAlign.center,
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _controller.extended
                            ? ListTile(
                                title: const Text(
                                  "User",
                                  style: TextStyle(
                                    color: Colors.white60,
                                  ),
                                ),
                                subtitle: Text(
                                  u.loggedInAppUser!.email == ''
                                      ? "Anonymous User"
                                      : u.loggedInAppUser!.email,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const CircleAvatar(
                                child: Icon(
                                  Icons.person,
                                  size: 32,
                                ),
                              ),
                        const SizedBox(height: 10),
                        _controller.extended
                            ? ListTile(
                                title: const Text(
                                  "Role",
                                  style: TextStyle(
                                    color: Colors.white60,
                                  ),
                                ),
                                subtitle: Text(
                                  u.loggedInAppUser!.role.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const CircleAvatar(
                                child: Icon(
                                  Icons.roller_shades,
                                  size: 23,
                                ),
                              ),
                      ],
                    ),
                  );
                },
              );
            },
            footerDivider: divider,
            footerItems: footerItems(),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: _animationController,
              child: _pageBuilderPages
                  .selectorBuilder(
                    context.read<PxAppUsers>().loggedInAppUser!.role,
                    context.read<PxAppUsers>().loggedInAppUser!.otherRoles,
                  )[_controller.selectedIndex]
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
