// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, must_be_immutable, sort_child_properties_last

import 'package:e_commerce_admin/model/order_constants_model.dart';
import 'package:e_commerce_admin/provider/order_provider.dart';
import 'package:e_commerce_admin/provider/product_provider.dart';
import 'package:e_commerce_admin/untils/colors.dart';
import 'package:e_commerce_admin/untils/constransts.dart';
import 'package:e_commerce_admin/untils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double deliveryChargeSliderValue = 0;
  double discountSliderValue = 0;
  double vatSliderValue = 0;
  late ProductProvider productProvider;
  late OrderProvider orderProvider;
  bool needUpdate = false;

  @override
  void didChangeDependencies() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orderProvider.getOrderConstants().then((_) {
      setState(() {
        deliveryChargeSliderValue =
            orderProvider.orderConstantsModel.deliveryCharge.toDouble();
        discountSliderValue =
            orderProvider.orderConstantsModel.discount.toDouble();
        vatSliderValue = orderProvider.orderConstantsModel.vat.toDouble();
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text('Delivery Charge'),
                    trailing: Text(
                        '$currencySymbol${deliveryChargeSliderValue.round()}'),
                  ),
                  Slider(
                    activeColor: appColor.cardColor,
                    inactiveColor: Colors.grey,
                    min: 0,
                    max: 500,
                    divisions: 50,
                    label: deliveryChargeSliderValue.toStringAsFixed(0),
                    value: deliveryChargeSliderValue.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        deliveryChargeSliderValue = value;
                        _cheakUpdate();
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Discount'),
                    trailing: Text('${discountSliderValue.round()}%'),
                  ),
                  Slider(
                    activeColor: appColor.cardColor,
                    inactiveColor: Colors.grey,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: discountSliderValue.toStringAsFixed(0),
                    value: discountSliderValue.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        discountSliderValue = value;
                        _cheakUpdate();
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Vat'),
                    trailing: Text('${vatSliderValue.round()}%'),
                  ),
                  Slider(
                    activeColor: appColor.cardColor,
                    inactiveColor: Colors.grey,
                    min: 0,
                    max: 150,
                    divisions: 150,
                    label: vatSliderValue.toStringAsFixed(0),
                    value: vatSliderValue.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        vatSliderValue = value;
                        _cheakUpdate();
                      });
                    },
                  ),
                  Container(
                    height: 40,
                    width: 120,
                    margin: EdgeInsets.only(bottom: 10, top: 10),
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
                        'Update',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: appColor.cardColor),
                      ),
                      onPressed: needUpdate
                          ? () {
                              final model = OrderConstantsModel(
                                deliveryCharge: deliveryChargeSliderValue,
                                discount: discountSliderValue,
                                vat: vatSliderValue,
                              );
                              orderProvider
                                  .addOrderConstants(model)
                                  .then((value) {
                                showMsg(context, 'Updated');
                                setState(() {
                                  needUpdate = false;
                                });
                              });
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _cheakUpdate() {
    needUpdate = deliveryChargeSliderValue !=
            orderProvider.orderConstantsModel.deliveryCharge.toDouble() ||
        discountSliderValue !=
            orderProvider.orderConstantsModel.discount.toDouble() ||
        vatSliderValue != orderProvider.orderConstantsModel.vat.toDouble();
  }
}
