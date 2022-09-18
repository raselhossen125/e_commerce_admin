
import 'package:e_commerce_admin/untils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/order_provider.dart';
import '../untils/constransts.dart';

class OrderListPage extends StatelessWidget {
  static const String routeName = '/order_list';

  const OrderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderFilter = ModalRoute.of(context)!.settings.arguments as OrderFilter;
    final orderList = Provider.of<OrderProvider>(context, listen: false).getFilteredOrderList(orderFilter);
    return Scaffold(
      appBar: AppBar(title: const Text('Order List'),),
      body: ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          final order = orderList[index];
          return ListTile(
            title: Text(getFormatedDateTime(order.dateModel.timestamp.toDate(), 'dd/MM/yyyy hh:mm:ss a')),
            trailing: Text('$currencySymbol${order.grandTotal}'),
          );
        },
      )
    );
  }
}
