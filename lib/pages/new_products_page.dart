import 'package:flutter/material.dart';

class NewProductsPage extends StatefulWidget {
  static const routeName = '/new-products';

  @override
  State<NewProductsPage> createState() => _NewProductsPageState();
}

class _NewProductsPageState extends State<NewProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Products'),
      ),
    );
  }
}
