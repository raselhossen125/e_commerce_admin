// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:e_commerce_admin/model/product_model.dart';
import 'package:e_commerce_admin/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) => ListView(
          children: [
            FadeInImage.assetNetwork(
              placeholder: 'images/product.jpg',
              image: product.imageUrl!,
              fadeInCurve: Curves.bounceInOut,
              fadeInDuration: Duration(seconds: 3),
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text(product.name!),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
