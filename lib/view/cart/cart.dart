// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/view/checkout/Address/delivary_details.dart';

import 'package:hungryhub/view/widgets/counter.dart';

import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../../controlls/cart_list_controller.dart';
import '../../domain/constants/constants.dart';
import '../menu/menu_screen.dart';

bool isCart = false;
int carrtInt = 0;

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  CartProductControll? cartProductControll;
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProductControll = Provider.of<CartProductControll>(context);
    cartProductControll.getCartList();

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
            //  Navigator.pop(context);
          },
        ),
        title: Text(
          'Cart',
          style: GoogleFonts.secularOne(fontSize: 30, color: Colors.black),
        ),
      ),
      body: cartProductControll.getcartDataList.isEmpty
          ? const Center(
              child: Text('No Data'),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
              child: GridView.builder(
                itemCount: cartProductControll.getcartDataList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (0.54 / 0.8),
                    crossAxisSpacing: 2,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final data = cartProductControll.getcartDataList[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    shadowColor: backgroundcolor,
                    elevation: 15,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            data.productImage,
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: height * 0.15,
                          ),
                        ),
                        Flexible(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: GoogleFonts.secularOne(
                                  fontSize: 20, color: Colors.black),
                              text: data.productName,
                            ),
                          ),
                        ),
                        Text(
                          '₹${data.productRate}',
                          style: GoogleFonts.secularOne(
                            fontSize: 25,
                          ),
                        ),
                        CounterWidget(
                          id: data.id,
                          productDescription: data.productDescription,
                          productImage: data.productImage,
                          productName: data.productName,
                          productRate: data.productRate,
                          productTime: data.productTime,
                          produtQuantity: 1,
                        ),
                        IconButton(
                            onPressed: () {
                              cartDeleteDialogue(context, data.id);
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  );
                },
              ),
            ),
      bottomNavigationBar: ListTile(
        title: Text(
          'Total Amount',
          style: GoogleFonts.secularOne(fontSize: 20, color: Colors.grey),
        ),
        subtitle: Text(
          '₹${cartProductControll.getTotalPrice() + cartProductControll.cartDataList.length * 10}',
          style: GoogleFonts.secularOne(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        trailing: SizedBox(
          width: width * 0.4,
          height: height * 0.5,
          child: MaterialButton(
            onPressed: () {
              isAddress = false;
              carrtInt = 1;
              isCart = true;
              if (cartProductControll.cartDataList.isEmpty) {
                showSimpleNotification(
                    Text(
                      'Cart Item is Empty',
                      style: GoogleFonts.secularOne(
                          fontSize: 20, color: Colors.amber),
                    ),
                    background: Colors.white,
                    duration: const Duration(milliseconds: 300));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddressDetails(),
                    ));
              }
            },
            color: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Text(
              'Submit',
              style: GoogleFonts.secularOne(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  cartDeleteDialogue(BuildContext context, var delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () async {
        await Provider.of<CartProductControll>(context, listen: false)
            .cartDeleteData(delete);

        Navigator.pop(context);
        showSimpleNotification(
            Text(
              'item removed from cart',
              style: GoogleFonts.secularOne(fontSize: 20, color: Colors.amber),
            ),
            background: Colors.white,
            duration: const Duration(milliseconds: 300));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Remove From Cart"),
      content: const Text("Do you like to remove this item from cart?"),
      actions: [
        cancelButton,
        continueButton,
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
}
