import 'package:e_commerce_admin/db/db_helper.dart';
import 'package:e_commerce_admin/model/order_constants_model.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();

  Future<void> addOrderConstants(OrderConstantsModel model) =>
      DBHelper.addOrderConstants(model);

  Future<void> getOrderConstants() async{
    final snapsort = await DBHelper.getOrderConstants();
    orderConstantsModel = OrderConstantsModel.fromMap(snapsort.data()!);
    notifyListeners();
  }
}
