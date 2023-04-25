// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:hungryhub/controller/services/order_history.dart';
import 'package:hungryhub/model/order_history_model.dart';
import 'package:hungryhub/view/orderhistory/inside_order_history.dart';

import '../../controller/constants/constants.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "order History",
          style: menuscreen20,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StreamBuilder(
                stream: getOrderHistoryStrem(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: snapshot.data!.isEmpty
                          ? const Center(
                              child: Text("no order history found"),
                            )
                          : ListView.separated(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final historyData = snapshot.data![index];

                                return ListTile(
                                  title: Text(historyData.paymentId),
                                  subtitle: Text(historyData.dateTime),
                                  trailing: Text(
                                    "₹${historyData.amount}",
                                    style: menuscreen20,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SingleOrderHistory(
                                            orderHistoryModel:
                                                OrderHistoryModel(
                                              amount: historyData.amount,
                                              dateTime: historyData.dateTime,
                                              paymentId: historyData.paymentId,
                                              productName:
                                                  historyData.productName,
                                              producutQuantity:
                                                  historyData.producutQuantity,
                                            ),
                                          ),
                                        ));
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return divider;
                              },
                            ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return Text("Something went wrong${snapshot.error}");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
