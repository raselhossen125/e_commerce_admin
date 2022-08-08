// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:e_commerce_admin/auth/auth_service.dart';
import 'package:e_commerce_admin/pages/launcher_page.dart';
import 'package:e_commerce_admin/untils/colors.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            color: appColor.cardColor,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      AuthService.logOut();
                      Navigator.of(context)
                          .pushReplacementNamed(LauncherPage.routeName);
                    },
                    leading: Icon(
                      Icons.logout,
                      color: appColor.cardColor,
                    ),
                    title: Text('Log Out'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
