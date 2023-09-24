// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/core/base_navigation_page/base_navigation_page.dart';
import 'package:single_vendor_admin_panel/pages/auth_page/auth_page.dart';
import 'package:single_vendor_admin_panel/pages/auth_page/routes/create_new_user/create_new_user.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/control_panel_main.dart';
import 'package:single_vendor_admin_panel/pages/loading_screen/loading_screen.dart';
import 'package:single_vendor_admin_panel/pages/select_server/select_server_page.dart';
import 'package:single_vendor_admin_panel/providers/px_localization.dart';

class RoutingLogic {
  const RoutingLogic();

  static final GoRouter router = GoRouter(
    initialLocation: "/",
    refreshListenable: PxLocalization(),
    routes: [
      GoRoute(
        path: '/',
        name: 'base',
        builder: (context, state) {
          return BaseNavigationPage(
            key: state.pageKey,
          );
        },
        redirect: (context, state) {
          if (state.fullPath == '/') {
            return '/en';
          }
          return null;
        },
        routes: [
          GoRoute(
            path: ':lang',
            name: PageDir.loading_screen.name,
            builder: (context, state) {
              final lang = state.pathParameters["lang"] as String;
              context.read<PxLocalization>().setLang(lang);
              final langKey = ValueKey(lang);
              return LoadingScreen(key: langKey);
            },
            routes: [
              GoRoute(
                path: PageDir.server_selection_page.name,
                name: PageDir.server_selection_page.name,
                builder: (context, state) {
                  return SelectServerPage(key: state.pageKey);
                },
              ),
              GoRoute(
                path: PageDir.auth_page.name,
                name: PageDir.auth_page.name,
                builder: (context, state) {
                  return AuthPage(key: state.pageKey);
                },
                routes: [
                  GoRoute(
                    path: PageDir.create_app_user_page.name,
                    name: PageDir.create_app_user_page.name,
                    builder: (context, state) {
                      return CreateNewAppUser(key: state.pageKey);
                    },
                  ),
                ],
              ),
              GoRoute(
                path: PageDir.control_panel_main.name,
                name: PageDir.control_panel_main.name,
                builder: (context, state) {
                  return ControlPanelMain(key: state.pageKey);
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

enum PageDir {
  base_navigation_page,
  loading_screen,
  server_selection_page,
  auth_page,
  create_app_user_page,
  control_panel_main,
}
