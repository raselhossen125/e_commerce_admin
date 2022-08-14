// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:e_commerce_admin/pages/product_details_page.dart';
import 'package:e_commerce_admin/untils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';
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
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) => provider.productList.isNotEmpty
            ? ListView.builder(
                itemCount: provider.productList.length,
                itemBuilder: (context, index) {
                  final product = provider.productList[index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(ProductDetailsPage.routeName, arguments: product.id);
                    },
                    title: Text(product.name!),
                  );
                },
              )
            : Center(
                child: Text('No Products Found'),
              ),
      ),
    );
  }
}
