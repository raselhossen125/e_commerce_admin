import 'package:e_commerce_admin/model/category_model.dart';
import 'package:e_commerce_admin/provider/product_provider.dart';
import 'package:e_commerce_admin/untils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  static const routeName = '/category';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColor.cardColor,
        onPressed: () {
          _showAddCategoryBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) => provider.categoryList.isNotEmpty
            ? ListView.builder(
                itemCount: provider.categoryList.length,
                itemBuilder: (context, index) {
                  final ctegory = provider.categoryList[index];
                  return ListTile(
                    title: Text('${ctegory.catName} (${ctegory.count})'),
                  );
                },
              )
            : Center(
                child: Text('No category Found'),
              ),
      ),
    );
  }

  void _showAddCategoryBottomSheet(BuildContext context) {
    final nameController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add category'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    cursorColor: appColor.cardColor,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        color: appColor.cardColor, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      contentPadding: EdgeInsets.only(left: 10),
                      focusColor: Colors.grey.withOpacity(0.1),
                      prefixIcon: Icon(
                        Icons.category,
                        size: 20,
                        color: appColor.cardColor,
                      ),
                      hintText: "Category Name",
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.normal),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context
                            .read<ProductProvider>()
                            .addCategory(CategoryModel(
                              catName: nameController.text,
                            ))
                            .then((value) {
                          nameController.clear();
                          Navigator.of(context).pop();
                        });
                      },
                      child: Text('Add')),
                ],
              ),
            ));
  }
}
