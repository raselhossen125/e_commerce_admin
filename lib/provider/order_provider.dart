import 'package:e_commerce_admin/db/db_helper.dart';
import 'package:e_commerce_admin/model/order_constants_model.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();

  Future<void> addOrderConstants(OrderConstantsModel model) =>
      DBHelper.addOrderConstants(model);

  getOrderConstants() {
    DBHelper.getOrderConstants().listen((event) {
      if (event.exists) {
        orderConstantsModel = OrderConstantsModel.fromMap(event.data()!);
        notifyListeners();
      }
    });
  }
}
