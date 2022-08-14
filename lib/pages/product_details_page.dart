// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/model/product_model.dart';
import 'package:e_commerce_admin/provider/product_provider.dart';
import 'package:e_commerce_admin/untils/colors.dart';
import 'package:e_commerce_admin/untils/constransts.dart';
import 'package:e_commerce_admin/untils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  static const routeName = '/product-details';
  final textController = TextEditingController();
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
                        SizedBox(height: 10),
                        FadeInImage.assetNetwork(
                          placeholder: 'images/product.jpg',
                          image: product.imageUrl!,
                          fadeInCurve: Curves.bounceInOut,
                          fadeInDuration: Duration(seconds: 3),
                          width: double.infinity,
                          height: 260,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Chip(
                                backgroundColor: appColor.cardColor,
                                labelStyle: TextStyle(color: Colors.white),
                                label: Text('Re-Purchase'),
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  provider.getPurchaseByProduct(pid);
                                  _showPurchaseHistoryBootomSheer(context);
                                },
                                child: Chip(
                                  backgroundColor: appColor.cardColor,
                                  labelStyle: TextStyle(color: Colors.white),
                                  label: Text('Purchase History'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(product.name!),
                          trailing: IconButton(
                            onPressed: () {
                              updateAlertDialog(
                                context,
                                'product name',
                                product.name,
                                (value) {
                                  provider.updateproduct(
                                    product.id!,
                                    ProductName,
                                    value,
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: appColor.cardColor,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text('$currencySymbol${product.salePrice}'),
                          trailing: IconButton(
                            onPressed: () {
                              updateAlertDialog(
                                context,
                                'product price',
                                product.salePrice.toString(),
                                (value) {
                                  provider.updateproduct(
                                    product.id!,
                                    ProductSalePrice,
                                    num.parse(value),
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: appColor.cardColor,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(product.descripton ?? 'Not Available'),
                          trailing: IconButton(
                            onPressed: () {
                              updateAlertDialog(
                                context,
                                'product descripton',
                                product.descripton,
                                (value) {
                                  provider.updateproduct(
                                    product.id!,
                                    ProductDescripton,
                                    value,
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: appColor.cardColor,
                            ),
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
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => Consumer<ProductProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.purchaseListOfSpecefixProduct.length,
          itemBuilder: (context, index) {
            final purModel = provider.purchaseListOfSpecefixProduct[index];
            return Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25))),
                child: ListTile(
                  title: Text(getFormatedDateTime(
                      purModel.dateModel.timestamp.toDate(), 'dd/MM/yyyy')),
                  subtitle: Text('Qunatity: ${purModel.productQuantity}'),
                  trailing: Text('$currencySymbol${purModel.purchasePrice}'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  updateAlertDialog(
    BuildContext context,
    String title,
    String? value,
    Function(String) onChange,
  ) {
    textController.text = value ?? '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${title}'),
        content: TextFormField(
          controller: textController,
          cursorColor: appColor.cardColor,
          keyboardType: TextInputType.emailAddress,
          style:
              TextStyle(color: appColor.cardColor, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
            contentPadding: EdgeInsets.only(left: 10),
            focusColor: Colors.grey.withOpacity(0.1),
            prefixIcon: Icon(
              Icons.circle,
              size: 20,
              color: appColor.cardColor,
            ),
            hintText: 'Enter ${title}',
            hintStyle:
                TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                textController.clear();
              },
              child: Text('Cancel')),
          TextButton(
              onPressed: () {
                onChange(textController.text);
                textController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Update')),
        ],
      ),
    );
  }
}
