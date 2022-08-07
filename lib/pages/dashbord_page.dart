// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:e_commerce_admin/model/dashbord_item.dart';
import 'package:e_commerce_admin/widgets/dashbord_item_view.dart';
import 'package:flutter/material.dart';

class DashbordPage extends StatelessWidget {
  static const routeName = '/dashbord';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashbord'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemCount: dashbordItems.length,
        itemBuilder: (context, index) {
          return DashbordItemView(
            item: dashbordItems[index],
            onPreased: (value) {},
          );
        },
      ),
    );
  }
}
