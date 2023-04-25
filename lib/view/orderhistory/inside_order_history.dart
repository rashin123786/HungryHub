import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hungryhub/controller/constants/constants.dart';
import 'package:hungryhub/model/order_history_model.dart';

class SingleOrderHistory extends StatelessWidget {
  const SingleOrderHistory({super.key, required this.orderHistoryModel});
  final OrderHistoryModel orderHistoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 10, right: 8),
            child: Padding(
              padding: const EdgeInsets.only(top: 60, left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "paymentId: ${orderHistoryModel.paymentId}",
                    style: menuscreen20,
                  ),
                  sizedboxHeight10,
                  Text(
                    orderHistoryModel.dateTime,
                  ),
                  sizedboxHeight50,
                  Expanded(
                    child: ListView.builder(
                      itemCount: orderHistoryModel.productName!.length,
                      itemBuilder: (context, index) {
                        final productname =
                            orderHistoryModel.productName![index];
                        final productquantity =
                            orderHistoryModel.producutQuantity![index];
                        final rate = orderHistoryModel.productRate![index];
                        return ListTile(
                          title: Text(
                            productname,
                            style: menuscreen20,
                          ),
                          subtitle: Text(
                            "₹$rate",
                            style: menuscreen20,
                          ),
                          trailing: Text(
                            "Qty:$productquantity",
                            style: menuscreen20,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: ListTile(
            title: Text(
              "Total:\n₹${orderHistoryModel.amount}",
              style: menuscreen20,
            ),
            trailing: SizedBox(
              child: ElevatedButton(
                child: Text("ok"),
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromWidth(200),
                  backgroundColor: backgroundcolor,
                ),
              ),
            ),
          ),
        ));
  }
}
