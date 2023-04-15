// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/controlls/cart_list_controller.dart';
import 'package:hungryhub/controlls/payment_controller.dart';
import 'package:hungryhub/domain/constants/constants.dart';
import 'package:hungryhub/view/Home/home.dart';
import 'package:hungryhub/view/cart/cart.dart';
import 'package:hungryhub/view/checkout/payment/view/succes_page.dart';
import 'package:hungryhub/view/checkout/payment/widgets/order_items.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  String? number;
  String? name;
  num cartint;

  PaymentScreen({super.key, this.name, this.number, required this.cartint});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

final _razorpay = Razorpay();

class _PaymentScreenState extends State<PaymentScreen> {
  var myType = PaymentType.cod;
  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    void addOrderHistory() async {
      datetime = DateTime.now().toString();
      await FirebaseFirestore.instance
          .collection("orderhistory")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("yourorder")
          .add({
        "paymentId": response.paymentId,
        "dateTime": datetime,
        "amount": isCart == true ? amount + 50 : allDatas.productRate + 50,
      });
    }

    addOrderHistory();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuccesPage(),
        ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showSimpleNotification(
        Text(
          'payment failed',
          style: GoogleFonts.secularOne(fontSize: 20, color: Colors.amber),
        ),
        background: Colors.white,
        duration: const Duration(milliseconds: 300));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showSimpleNotification(
        Text(
          response.walletName ?? 'External Wallet',
          style: GoogleFonts.secularOne(fontSize: 20, color: Colors.amber),
        ),
        background: Colors.white,
        duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentController>(context);

    final cartProvider = Provider.of<CartProductControll>(context);
    double subtotal = cartProvider.getTotalPrice();

    cartProvider.getCartList();
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('payment Summary'),
      ),
      bottomNavigationBar: ListTile(
        title: Text(
          'Total Amount',
          style: menuscreen20,
        ),
        subtitle: isCart == true
            ? Text("₹${subtotal + 50}", style: menuscreen20)
            : Text("₹${allDatas.productRate + 50}", style: menuscreen20),
        trailing: SizedBox(
          width: width * 0.4,
          height: height * 0.5,
          child: MaterialButton(
            onPressed: () async {
              if (pay == 2) {
                isCart == true ? amount = subtotal + 50 : null;
                var options = {
                  'key': 'rzp_test_DlGayWYnDCQqKY',
                  'amount': isCart == true
                      ? (subtotal + 50) * 100
                      : (allDatas.productRate + 50) * 100,
                  'name': widget.name,
                  'description': "Delightful delivery,\nwherever you are.",
                  'prefill': {
                    'contact': '8129366706',
                    'email': 'rashin396@gmail.com'
                  }
                };

                _razorpay.open(options);
              } else if (pay == 1) {
                codDialgoue(context);
              }
            },
            color: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Text(
              'Place Order',
              style: GoogleFonts.secularOne(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('${widget.name}'),
                  subtitle: Text("+91 ${widget.number}"),
                ),
                divider,
                isCart == true
                    ? ExpansionTile(
                        title: Text(
                            'order Item : ${cartProvider.getcartDataList.length}'),
                        children: cartProvider.getcartDataList.map((e) {
                          return OrderItems(
                            cartModel: e,
                          );
                        }).toList(),
                      )
                    : ExpansionTile(
                        title: const Text(
                          "order items : 1",
                        ),
                        children: [
                          ListTile(
                            title: Text(allDatas.productName),
                            leading: Image.network(
                              allDatas.productImage,
                            ),
                            trailing: isOffer == true
                                ? Text("₹${(allDatas.productRate)}")
                                : Text(
                                    "₹${((allDatas.productRate / 100) * 30).floorToDouble() + 10}"),
                          )
                        ],
                      ),
                divider,
                ListTile(
                  title: const Text('subtotal'),
                  trailing: isCart == true
                      ? Text("₹$subtotal")
                      : isOffer == true
                          ? Text("₹${allDatas.productRate}")
                          : Text(
                              "₹${((allDatas.productRate / 100) * 30).floorToDouble() + 10}"),
                ),
                const ListTile(
                  title: Text('shipping charge'),
                  trailing: Text('₹50'),
                ),
                divider,
                ListTile(
                  title: Text(
                    'Total',
                    style: menuscreen20,
                  ),
                  trailing: isCart == true
                      ? Text(
                          "₹${subtotal + 50}",
                          style: menuscreen20,
                        )
                      : Text(
                          "₹${allDatas.productRate + 50}",
                          style: menuscreen20,
                        ),
                ),
                divider,
                Text(
                  "Payment Option",
                  style: menuscreen20,
                ),
                RadioListTile(
                  value: PaymentType.cod,
                  groupValue: paymentProvider.myPay,
                  title: const Text('Cash On Delivary'),
                  onChanged: (value) async {
                    pay = 1;
                    paymentProvider.checkPymentMethod(value!);
                  },
                ),
                RadioListTile(
                  value: PaymentType.onlinepayment,
                  groupValue: paymentProvider.myPay,
                  title: const Text('online Payment'),
                  onChanged: (value) {
                    // Navigator.popUntil(
                    //     context, (route) => route.isFirst == HomeScreen());
                    pay = 2;
                    paymentProvider.checkPymentMethod(value!);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

codDialgoue(BuildContext context) {
  Widget okButton = ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).popUntil((route) => route.isFirst);
    },
  );

  AlertDialog alert = AlertDialog(
    backgroundColor: backgroundcolor,
    title: Image.network(
      "https://www.gclimousine.sg/wp-content/uploads/2022/04/tick.gif",
      width: 200,
      height: 200,
      fit: BoxFit.cover,
    ),
    content: const Text(
        "Thank you for choosing cash on delivery. Please keep the exact amount ready for our delivery executive. Enjoy your purchase!"),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
