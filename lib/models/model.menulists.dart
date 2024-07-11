import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String url;
  final IconData icon;
  final Widget view;
  final String description;
  final List<MenuItem>? subMenuItems; // Add this line

  MenuItem({
    required this.title,
    required this.url,
    required this.icon,
    required this.view,
    required this.description,
    this.subMenuItems, // Add this line
  });
}

class MenuList {
  final String url;
  final Widget view;

  MenuList({
    required this.url,
    required this.view,
  });
}
