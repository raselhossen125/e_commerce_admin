// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/model/product_model.dart';
import 'package:e_commerce_admin/model/purchase_model.dart';
import 'package:e_commerce_admin/provider/product_provider.dart';
import 'package:e_commerce_admin/untils/colors.dart';
import 'package:e_commerce_admin/untils/constransts.dart';
import 'package:e_commerce_admin/untils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    final pid = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) =>
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: provider.getProductById(pid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final product =
                        ProductModel.fromMap(snapshot.data!.data()!);
                    return ListView(
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
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 13, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Chip(
                                label: Text('Re-Purchase'),
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  provider.getPurchaseByProduct(pid);
                                  _showPurchaseHistoryBootomSheer(context);
                                },
                                child: Chip(
                                  label: Text('Purchase History'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(product.name!),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit),
                          ),
                        ),
                        ListTile(
                          title: Text('$currencySymbol${product.salePrice}'),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit),
                          ),
                        ),
                        ListTile(
                          title: Text(product.descripton ?? 'Not Available'),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit),
                          ),
                        ),
                        SwitchListTile(
                          activeColor: appColor.cardColor,
                          inactiveTrackColor: Colors.grey,
                          inactiveThumbColor: Colors.grey.withOpacity(0.3),
                          title: Text('Available'),
                          value: product.available,
                          onChanged: (value) {
                            provider.updateproduct(
                                product.id!, ProductAvailable, value);
                          },
                        ),
                        SwitchListTile(
                          activeColor: appColor.cardColor,
                          inactiveTrackColor: Colors.grey,
                          inactiveThumbColor: Colors.grey.withOpacity(0.3),
                          title: Text('Featured'),
                          value: product.featured,
                          onChanged: (value) {
                            provider.updateproduct(
                                product.id!, ProductFeatured, value);
                          },
                        ),
                      ],
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Failed'),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
      ),
    );
  }

  void _showPurchaseHistoryBootomSheer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Consumer<ProductProvider>(
        builder: (context, provider, child) => 
        ListView.builder(
          itemCount: provider.purchaseListOfSpecefixProduct.length,
          itemBuilder: (context, index) {
            final purModel = provider.purchaseListOfSpecefixProduct[index];
            return ListTile(
              title: Text(getFormatedDateTime(
                  purModel.dateModel.timestamp.toDate(), 'dd/MM/yyyy')),
              subtitle: Text('Qunatity: ${purModel.productQuantity}'),
              trailing: Text('$currencySymbol${purModel.purchasePrice}'),
            );
          },
        ),
      ),
    );
  }

  void updateAlertDialog() {
    
  }
}
