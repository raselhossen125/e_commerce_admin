// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:e_commerce_admin/model/dashbord_item.dart';
import 'package:e_commerce_admin/pages/category_page.dart';
import 'package:e_commerce_admin/pages/new_products_page.dart';
import 'package:e_commerce_admin/pages/orders_page.dart';
import 'package:e_commerce_admin/pages/products_page.dart';
import 'package:e_commerce_admin/pages/report_page.dart';
import 'package:e_commerce_admin/pages/settings_page.dart';
import 'package:e_commerce_admin/pages/users_page.dart';
import 'package:e_commerce_admin/provider/product_provider.dart';
import 'package:e_commerce_admin/untils/colors.dart';
import 'package:e_commerce_admin/widgets/dashbord_item_view.dart';
import 'package:e_commerce_admin/widgets/main_dawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashbordPage extends StatelessWidget {
  static const routeName = '/dashbord';

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getAllcategories();
    return Scaffold(
      backgroundColor: appColor.bgColor,
      appBar: AppBar(
        title: Text('Dashbord'),
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: dashbordItems.length,
          itemBuilder: (context, index) {
            return DashbordItemView(
              item: dashbordItems[index],
              onPreased: (value) {
                String route = navigator(value);
                Navigator.of(context).pushNamed(route);
              },
            );
          },
        ),
      ),
    );
  }

  String navigator(String value) {
    String route = '';
    switch (value) {
      case DashbordItem.user:
        route = UsersPage.routeName;
        break;
      case DashbordItem.settings:
        route = SettingsPage.routeName;
        break;
      case DashbordItem.category:
        route = CategoryPage.routeName;
        break;
      case DashbordItem.order:
        route = OrdersPage.routeName;
        break;
      case DashbordItem.product:
        route = ProductsPage.routeName;
        break;
      case DashbordItem.report:
        route = ReportPage.routeName;
        break;
    }
    return route;
  }
}
