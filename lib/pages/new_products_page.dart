// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_field, sized_box_for_whitespace, unused_local_variable, unused_element, avoid_unnecessary_containers

import 'dart:io';
import 'package:e_commerce_admin/provider/product_provider.dart';
import 'package:e_commerce_admin/untils/colors.dart';
import 'package:e_commerce_admin/widgets/new_product_textField.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewProductsPage extends StatefulWidget {
  static const routeName = '/new-products';
  @override

  State<NewProductsPage> createState() => _NewProductsPageState();
}

class _NewProductsPageState extends State<NewProductsPage> {
  final _formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final productSalePriceController = TextEditingController();
  final productDescriptonController = TextEditingController();
  final purchasePriceController = TextEditingController();
  final purchaseQuantityController = TextEditingController();

  String? pickeddate;
  String? imagePath;
  bool isGalary = true;
  String? selectedValue;

  @override
  void dispose() {
    productNameController.dispose();
    productSalePriceController.dispose();
    productDescriptonController.dispose();
    purchasePriceController.dispose();
    purchaseQuantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Products'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 4),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Purchase Date :',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  showDatePickerDialog();
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
                      Text(
                        pickeddate == null
                            ? DateFormat('dd/MM/yyyy').format(DateTime.now())
                            : pickeddate!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Card(
                elevation: 4,
                child: Container(
                  height: 250,
                  width: double.infinity,
                  child: Center(
                      child: imagePath == null
                          ? Image.asset(
                              'images/product.jpg',
                              height: 250,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(imagePath!),
                              height: 250,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )),
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 4,
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Text(
                      'Chose  Photo',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: appColor.cardColor,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                isGalary = false;
                                _getImage();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  border: Border.all(
                                    width: 0.5,
                                    color: appColor.cardColor,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Camera',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: appColor.cardColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 50),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                isGalary = true;
                                _getImage();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  border: Border.all(
                                    width: 0.5,
                                    color: appColor.cardColor,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Galary',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: appColor.cardColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Category :',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      FittedBox(
                        child: Text(
                          selectedValue == null
                              ? 'No category Selected'
                              : selectedValue!,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Spacer(),
                      Consumer<ProductProvider>(
                        builder: (context, provider, _) => DropdownButton(
                          borderRadius: BorderRadius.circular(15),
                          underline: Text(""),
                          dropdownColor: Colors.white,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: appColor.cardColor,
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 18),
                          items: provider.categoryList.map((model) {
                            return DropdownMenuItem(
                             value: model.catName,
                              child: Text(model.catName!),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedValue = newValue.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    NewProductTextField(
                      controller: productNameController,
                      hintText: 'Product Name',
                      prefixIcon: Icons.card_giftcard,
                    ),
                    SizedBox(height: 15),
                    NewProductTextField(
                      controller: productSalePriceController,
                      hintText: 'Product Sale Price',
                      prefixIcon: Icons.monetization_on,
                      keyBordType: TextInputType.number,
                    ),
                    SizedBox(height: 15),
                    NewProductTextField(
                      controller: purchasePriceController,
                      hintText: 'Purchase Price',
                      prefixIcon: Icons.monetization_on,
                      keyBordType: TextInputType.number,
                    ),
                    SizedBox(height: 15),
                    NewProductTextField(
                      controller: purchaseQuantityController,
                      hintText: 'Purchase Quantity',
                      prefixIcon: Icons.add,
                      keyBordType: TextInputType.number,
                    ),
                    SizedBox(height: 15),
                    NewProductTextField(
                      controller: productDescriptonController,
                      hintText: 'Product Descripton',
                      prefixIcon: Icons.text_increase,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: appColor.cardColor,
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getImage() async {
    final status = isGalary;
    final selectedImage = await ImagePicker()
        .pickImage(source: isGalary ? ImageSource.gallery : ImageSource.camera);
    if (selectedImage != null) {
      setState(() {
        imagePath = selectedImage.path;
      });
    }
  }

  Future<void> showDatePickerDialog() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        pickeddate = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }
}
