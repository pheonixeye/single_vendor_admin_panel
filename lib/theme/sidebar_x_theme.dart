import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);

const sidebarXthemeExtendedDark = SidebarXTheme(
  width: 200,
  decoration: BoxDecoration(
    color: canvasColor,
  ),
);
final sidebarXthemeRegularDark = SidebarXTheme(
  margin: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    color: canvasColor,
    borderRadius: BorderRadius.circular(20),
  ),
  hoverColor: Colors.orange.shade300,
  textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
  selectedTextStyle: const TextStyle(color: Colors.white),
  itemTextPadding: const EdgeInsets.only(left: 30),
  selectedItemTextPadding: const EdgeInsets.only(left: 30),
  itemDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: canvasColor),
  ),
  selectedItemDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: actionColor.withOpacity(0.37),
    ),
    gradient: const LinearGradient(
      colors: [accentCanvasColor, canvasColor],
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.28),
        blurRadius: 30,
      )
    ],
  ),
  iconTheme: IconThemeData(
    color: Colors.white.withOpacity(0.7),
    size: 20,
  ),
  selectedIconTheme: const IconThemeData(
    color: Colors.white,
    size: 28,
  ),
);

final sidebarXthemeExtendedLight = SidebarXTheme(
  width: 250,
  hoverColor: Colors.orange.shade200,
  itemPadding: const EdgeInsets.all(4),
  selectedItemTextPadding: const EdgeInsets.symmetric(horizontal: 12),
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
);
final sidebarXthemeRegularLight = SidebarXTheme(
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
  hoverColor: Colors.orange.shade200,
);
