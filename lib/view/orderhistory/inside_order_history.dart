import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hungryhub/model/order_history_model.dart';

class SingleOrderHistory extends StatelessWidget {
  const SingleOrderHistory({super.key, required this.orderHistoryModel});
  final OrderHistoryModel orderHistoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text(orderHistoryModel.dateTime),
          Expanded(
            child: ListView.builder(
              itemCount: orderHistoryModel.productName!.length,
              itemBuilder: (context, index) {
                final productname = orderHistoryModel.productName![index];
                return ListTile(
                  title: Text(productname),
                  trailing: Text("${orderHistoryModel.producutQuantity}"),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
