import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  static const routeName = '/products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
    );
  }
}