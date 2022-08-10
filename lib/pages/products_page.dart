// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:e_commerce_admin/untils/colors.dart';
import 'package:flutter/material.dart';

import 'new_products_page.dart';

class ProductsPage extends StatelessWidget {
  static const routeName = '/products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColor.cardColor,
        onPressed: () {
          Navigator.of(context).pushNamed(NewProductsPage.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
