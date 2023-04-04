// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/domain/services/offer.dart';
import 'package:hungryhub/model/cart_model.dart.dart';
import 'package:hungryhub/view/Home/widgets/counter.dart';
import 'package:hungryhub/view/Home/widgets/popular_food.dart';
import 'package:provider/provider.dart';

import '../../controlls/cart_list_controller.dart';
import '../../domain/constants/constants.dart';

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
    print(cartProductControll.getcartDataList.length);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
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
                    childAspectRatio: (0.55 / 0.8),
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
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                data.productImage,
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: height * 0.2,
                              ),
                            ),
                            Positioned(
                              left: width * 0.365,
                              top: height * 0.15,
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.amber,
                                      size: 35,
                                    )),
                              ),
                            )
                          ],
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
                          '${data.productRate}',
                          style: GoogleFonts.secularOne(
                            fontSize: 25,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                        )
                      ],
                    ),
                  );
                },
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 350),
            content: Text(
              'item removed from cart',
            ),
          ),
        );
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
