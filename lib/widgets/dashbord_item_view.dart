// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:e_commerce_admin/model/dashbord_item.dart';
import 'package:e_commerce_admin/untils/colors.dart';
import 'package:flutter/material.dart';

class DashbordItemView extends StatelessWidget {
  final DashbordItem item;
  Function(String) onPreased;

  DashbordItemView({
    required this.item,
    required this.onPreased,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPreased(item.title);
      },
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              size: 35,
              color: appColor.cardColor,
            ),
            SizedBox(height: 10),
            Text(
              item.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
