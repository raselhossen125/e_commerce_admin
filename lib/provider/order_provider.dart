import 'package:e_commerce_admin/db/db_helper.dart';
import 'package:e_commerce_admin/model/order_constants_model.dart';
import 'package:flutter/cupertino.dart';

import '../model/order_model.dart';
import '../untils/constransts.dart';

class OrderProvider extends ChangeNotifier {
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();
  List<OrderModel> orderList = [];

  Future<void> addOrderConstants(OrderConstantsModel model) =>
      DBHelper.addOrderConstants(model);

  Future<void> getOrderConstants() async{
    final snapsort = await DBHelper.getOrderConstants();
    orderConstantsModel = OrderConstantsModel.fromMap(snapsort.data()!);
    notifyListeners();
  }

  void getAllOrders() {
    DBHelper.getAllOrders().listen((event) {
      orderList = List.generate(event.docs.length,
          (index) => OrderModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

   num getTotalOrderByDate(DateTime dateTime) {
    final filteredList = orderList.where((element) =>
    element.dateModel.day == dateTime.day &&
    element.dateModel.month == dateTime.month &&
    element.dateModel.year == dateTime.year)
        .toList();
    return filteredList.length;
  }

  num getTotalOrderByDateRange(DateTime dateTime) {
    final filteredList = orderList.where((element) =>
    element.dateModel.timestamp.toDate().isAfter(dateTime))
        .toList();

    return filteredList.length;
  }

  num getTotalSaleByDate(DateTime dateTime) {
    num total = 0;
    final filteredList = orderList.where((element) =>
    element.dateModel.day == dateTime.day &&
        element.dateModel.month == dateTime.month &&
        element.dateModel.year == dateTime.year)
        .toList();
    for(var order in filteredList) {
      total += order.grandTotal;
    }
    return total.round();
  }

  num getTotalSaleByDateRange(DateTime dateTime) {
    num total = 0;
    final filteredList = orderList.where((element) =>
        element.dateModel.timestamp.toDate().isAfter(dateTime))
        .toList();
    for(var order in filteredList) {
      total += order.grandTotal;
    }
    return total.round();
  }

  num getAllTimeTotalSale() {
    num total = 0;
    for(var order in orderList) {
      total += order.grandTotal;
    }
    return total.round();
  }

  List<OrderModel> getFilteredOrderList(OrderFilter filter) {
    var filteredList = <OrderModel>[];
    switch(filter) {
      case OrderFilter.TODAY:
        filteredList = orderList.where((element) =>
        element.dateModel.day == DateTime.now().day &&
            element.dateModel.month == DateTime.now().month &&
            element.dateModel.year == DateTime.now().year)
            .toList();
        break;
      case OrderFilter.YESTERDAY:

        break;
      case OrderFilter.SEVEN_DAYS:

        break;
      case OrderFilter.THIS_MONTH:

        break;
      case OrderFilter.ALL_TIME:

        break;
    }
    return filteredList;
  }

}
