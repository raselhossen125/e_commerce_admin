import 'package:flutter/material.dart';

class DashbordItem {
  IconData icon;
  String title;

  DashbordItem({
    required this.icon,
    required this.title,
  });

  static const String product = 'Product';
  static const String category = 'Category';
  static const String order = 'Orders';
  static const String user = 'Users';
  static const String settings = 'Settings';
  static const String report = 'Report';
}

final List<DashbordItem> dashbordItems = [
  DashbordItem(icon: Icons.card_giftcard, title: DashbordItem.product),
  DashbordItem(icon: Icons.category, title: DashbordItem.category),
  DashbordItem(icon: Icons.monetization_on, title: DashbordItem.order),
  DashbordItem(icon: Icons.person, title: DashbordItem.user),
  DashbordItem(icon: Icons.settings, title: DashbordItem.settings),
  DashbordItem(icon: Icons.area_chart, title: DashbordItem.report),
];
