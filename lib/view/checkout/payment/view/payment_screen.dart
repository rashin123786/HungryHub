// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:hungryhub/controller/constants/constants.dart';
import 'package:hungryhub/model/all_product_model.dart.dart';
import 'package:hungryhub/model/cart_model.dart.dart';

import 'package:hungryhub/view/cart/cart.dart';
import 'package:hungryhub/view/checkout/payment/view/succes_page.dart';
import 'package:hungryhub/view/checkout/payment/widgets/order_items.dart';

import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../controller/provider/cart_list_controller.dart';
import '../../../../controller/provider/payment_controller.dart';

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

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    paymentId = response.paymentId ?? '';

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SuccesPage(),
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
    if (isCart == false) {
      bool isExist = cartModelList.any(
        (cartModel) => cartModel.productName == allDatas.productName,
      );
      if (!isExist) {
        CartModel allProductDetails = CartModel(
          productImage: allDatas.productImage,
          productName: allDatas.productName,
          productRate: allDatas.productRate,
          productDescription: allDatas.productDescription,
          productTime: allDatas.productTime,
          produtQuantity: 1,
        );
        cartModelList.add(allProductDetails);
      }
    }

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
                if (isCart == true) {
                  Provider.of<PaymentController>(context, listen: false)
                      .deletecart();
                }
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
                ExpansionTile(
                  title: isCart == true
                      ? Text(
                          'order Item : ${cartProvider.getcartDataList.length}')
                      : const Text("order items : 1"),
                  children: isCart == true
                      ? cartProvider.getcartDataList.map((cartData) {
                          bool isExist = cartModelList.any(
                            (cartModel) =>
                                cartModel.productName == cartData.productName,
                          );
                          if (!isExist) {
                            CartModel allProductDetails = CartModel(
                              productImage: cartData.productImage,
                              productName: cartData.productName,
                              productRate: cartData.productRate,
                              productDescription: cartData.productDescription,
                              productTime: cartData.productTime,
                              produtQuantity: cartData.produtQuantity,
                            );
                            cartModelList.add(allProductDetails);
                          }
                          return OrderItems(
                            cartModel: cartData,
                          );
                        }).toList()
                      : [
                          ListTile(
                            title: Text(allDatas.productName),
                            leading: Image.network(
                              allDatas.productImage,
                            ),
                            trailing: isOffer == true
                                ? Text("₹${(allDatas.productRate)}")
                                : Text(
                                    "₹${((allDatas.productRate / 100) * 30).floorToDouble() + 10}"),
                          ),
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
