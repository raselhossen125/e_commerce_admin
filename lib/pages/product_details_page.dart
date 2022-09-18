// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/model/product_model.dart';
import 'package:e_commerce_admin/provider/product_provider.dart';
import 'package:e_commerce_admin/untils/colors.dart';
import 'package:e_commerce_admin/untils/constransts.dart';
import 'package:e_commerce_admin/untils/helper_function.dart';
import 'package:e_commerce_admin/widgets/new_product_textField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  static const routeName = '/product-details';
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pid = ModalRoute.of(context)!.settings.arguments as String;
    final provider = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: provider.getProductById(pid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final product = ProductModel.fromMap(snapshot.data!.data()!);
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
                    padding:
                        const EdgeInsets.only(top: 25, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _showRePurchaseBootomSheet(context,
                                ((price, quantity, date) {
                              provider
                                  .rePurchase(pid, price, quantity, date,
                                      product.category!, product.stock!)
                                  .then((value) {
                                Navigator.of(context).pop();
                              }).catchError((error) {
                                showMsg(context, 'Could not save');
                                throw error;
                              });
                            }));
                          },
                          child: Chip(
                            backgroundColor: appColor.cardColor,
                            labelStyle: TextStyle(color: Colors.white),
                            label: Text('Re-Purchase'),
                          ),
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
    );
  }

  void _showPurchaseHistoryBootomSheer(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) =>
          Consumer<ProductProvider>(builder: (context, provider, child) {
        return Column(
          children: [
            SizedBox(height: 15),
            Text(
              'Purchase History',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: appColor.cardColor),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provider.purchaseListOfSpecefixProduct.length,
                itemBuilder: (context, index) {
                  final purModel =
                      provider.purchaseListOfSpecefixProduct[index];
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
                            purModel.dateModel.timestamp.toDate(),
                            'dd/MM/yyyy')),
                        subtitle: Text('Qunatity: ${purModel.productQuantity}'),
                        trailing:
                            Text('$currencySymbol${purModel.purchasePrice}'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
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

  void _showRePurchaseBootomSheet(
    BuildContext context,
    Function(num price, num quantity, DateTime date) onSave,
  ) {
    final pController = TextEditingController();
    final qController = TextEditingController();
    ValueNotifier<DateTime> dateTimeNotyfier = ValueNotifier(DateTime.now());
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(16),
          children: [
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                dateTimeNotyfier.value = await showDatePickerDialog(context);
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: appColor.cardColor,
                ),
                child: Row(
                  children: [
                    SizedBox(width: 16),
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 110),
                    ValueListenableBuilder(
                      valueListenable: dateTimeNotyfier,
                      builder: (context, value, _) => Text(
                        getFormatedDateTime(value as DateTime, 'dd/MM/yyyy'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25),
            NewProductTextField(
              controller: pController,
              hintText: 'Enter price',
              prefixIcon: Icons.monetization_on,
              keyBordType: TextInputType.number,
            ),
            SizedBox(height: 15),
            NewProductTextField(
              controller: qController,
              hintText: 'Enter quantity',
              prefixIcon: Icons.add,
              keyBordType: TextInputType.number,
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 130,
                  margin: EdgeInsets.only(bottom: 20),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      side: BorderSide(
                        color: appColor.cardColor,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      'Re-Purchase',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: appColor.cardColor),
                    ),
                    onPressed: () {
                      onSave(
                        num.parse(pController.text),
                        num.parse(qController.text),
                        dateTimeNotyfier.value,
                      );
                    },
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  height: 40,
                  width: 140,
                  margin: EdgeInsets.only(bottom: 20),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      side: BorderSide(
                        color: appColor.cardColor,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: appColor.cardColor),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime> showDatePickerDialog(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      return selectedDate;
    }
    return DateTime.now();
  }
}
