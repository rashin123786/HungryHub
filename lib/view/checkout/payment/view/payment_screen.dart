import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/domain/constants/constants.dart';
import 'package:hungryhub/view/checkout/payment/widgets/order_items.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

enum paymentType { cod, onlinepayment }

class _PaymentScreenState extends State<PaymentScreen> {
  var myType = paymentType.cod;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('payment Summary'),
        ),
        bottomNavigationBar: ListTile(
          title: Text(
            'Total Amount',
            style: GoogleFonts.secularOne(fontSize: 20, color: Colors.grey),
          ),
          subtitle: Text(
            '₹1000',
            style: GoogleFonts.secularOne(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          trailing: SizedBox(
            width: width * 0.4,
            height: height * 0.5,
            child: MaterialButton(
              onPressed: () {},
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Full Name'),
                  subtitle: Text('area,landmark,city'),
                ),
                divider,
                ExpansionTile(
                  children: [
                    OrderItems(),
                    OrderItems(),
                  ],
                  title: Text('order Item : 10'),
                ),
                divider,
                ListTile(
                  title: Text('subtotal'),
                  trailing: Text('rate'),
                ),
                ListTile(
                  title: Text('shipping charge'),
                  trailing: Text('50'),
                ),
                ListTile(
                  title: Text('subtotal'),
                  trailing: Text('rate'),
                ),
                divider,
                Text("Payment Option"),
                RadioListTile(
                  value: paymentType.cod,
                  groupValue: myType,
                  title: Text('Cod'),
                  onChanged: (value) {
                    setState(() {
                      myType = value!;
                    });
                  },
                ),
                RadioListTile(
                  value: paymentType.onlinepayment,
                  groupValue: myType,
                  title: Text('online Payment'),
                  onChanged: (value) {
                    setState(() {
                      myType = value!;
                    });
                  },
                ),
              ],
            );
          },
        ));
  }
}
