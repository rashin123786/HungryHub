import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/controlls/cart_list_controller.dart';
import 'package:hungryhub/domain/constants/constants.dart';
import 'package:hungryhub/view/cart/cart.dart';
import 'package:hungryhub/view/checkout/payment/widgets/order_items.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

int pay = 1;

class PaymentScreen extends StatefulWidget {
  String? number;
  String? name;
  int cartint;

  PaymentScreen({super.key, this.name, this.number, required this.cartint});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

enum paymentType { cod, onlinepayment }

final _razorpay = Razorpay();
// void gettransaction(paymentId)async{
//   Map<String,dynamic> result = await _razorpay.ge

// }

class _PaymentScreenState extends State<PaymentScreen> {
  var myType = paymentType.cod;
  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(response.paymentId);
    print(response.orderId);
    print(response.signature);
    print("payment sucesssss");
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("payment failedddd");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print("external wallet selected");
  }

  @override
  Widget build(BuildContext context) {
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
            style: GoogleFonts.secularOne(fontSize: 20, color: Colors.grey),
          ),
          subtitle: isCart == true
              ? Text(
                  "₹${subtotal + 50}",
                  style: GoogleFonts.secularOne(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                )
              : Text(
                  "₹${allDatas.productRate + 50}",
                  style: GoogleFonts.secularOne(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
          trailing: SizedBox(
            width: width * 0.4,
            height: height * 0.5,
            child: MaterialButton(
              onPressed: () async {
                if (pay == 2) {
                  var options = {
                    'key': 'rzp_test_DlGayWYnDCQqKY',
                    'amount': 100,
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
                  print("cod successssssssssssssssssssssssss");
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
                          title: Text(
                            "order items : 1",
                          ),
                          children: [
                            ListTile(
                              title: Text(allDatas.productName),
                              leading: Image.network(
                                allDatas.productImage,
                              ),
                              trailing: Text("₹${(allDatas.productRate)}"),
                            )
                          ],
                        ),
                  divider,
                  ListTile(
                    title: Text('subtotal'),
                    trailing: isCart == true
                        ? Text("₹${subtotal}")
                        : Text("${allDatas.productRate}"),
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
                    value: paymentType.cod,
                    groupValue: myType,
                    title: const Text('Cash On Delivary'),
                    onChanged: (value) {
                      setState(() {
                        pay = 1;
                        myType = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    value: paymentType.onlinepayment,
                    groupValue: myType,
                    title: const Text('online Payment'),
                    onChanged: (value) {
                      setState(() {
                        pay = 2;
                        myType = value!;
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ));
  }
}

codDialgoue(BuildContext context) {
  // set up the button
  Widget okButton = ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: backgroundcolor,
    title: Image.network(
      "https://www.gclimousine.sg/wp-content/uploads/2022/04/tick.gif",
      width: 200,
      height: 200,
      fit: BoxFit.cover,
    ),
    content: Text(
        "Thank you for choosing cash on delivery. Please keep the exact amount ready for our delivery executive. Enjoy your purchase!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
