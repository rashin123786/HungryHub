import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/controlls/check_out_controller.dart';

import 'package:hungryhub/domain/constants/constants.dart';
import 'package:hungryhub/model/address_model.dart';
import 'package:hungryhub/view/checkout/Address/add_delivary_address.dart';
import 'package:hungryhub/view/checkout/Address/single_delivary_item.dart';
import 'package:hungryhub/view/checkout/payment/view/payment_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../../../controlls/add_address.dart';

int isSelectedIndex = 0;
int isTap = 0;
bool isEdit = false;
String idss = '';

class AddressDetails extends StatefulWidget {
  const AddressDetails({super.key});

  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  @override
  Widget build(BuildContext context) {
    final addAddressProvider = Provider.of<AddAddressController>(context);
    final checkoutProvider = Provider.of<CheckOutController>(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addAddressProvider.getAllAddress();
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Delivary Address'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: backgroundcolor,
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          isEdit = false;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddDelivaryAddress(),
              ));
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            ListTile(
              leading: Image.asset(
                'assets/images/delivary.png',
                height: 30,
              ),
              title: Text(
                "Delivar To",
                style: GoogleFonts.secularOne(
                  fontSize: 18,
                ),
              ),
            ),
            divider2,
            addAddressProvider.getResultAddressDetails.isEmpty
                ? Center(
                    child: Text('No address Found'),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount:
                          addAddressProvider.getResultAddressDetails.length,
                      itemBuilder: (context, index) {
                        bool isSlected = index == isSelectedIndex;
                        final data =
                            addAddressProvider.getResultAddressDetails[index];
                        return Container(
                          color: isSlected ? Colors.amber : null,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelectedIndex = index;
                                allAddressData = DelivaryAddressModel(
                                  fullname: data.fullname,
                                  number: data.number,
                                );
                                print(allAddressData.fullname);
                              });
                            },
                            child: ListTile(
                              title: Text(
                                data.fullname ?? '',
                                style: menuscreen20,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("+91 ${data.fullname}"),
                                  Text("${data.street},${data.landMark}"),
                                  Text("${data.city},${data.pincode}"),
                                  Text("${data.city},${data.pincode}"),
                                ],
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 10,
                              ),
                              trailing: PopupMenuButton(
                                itemBuilder: (context) {
                                  return <PopupMenuItem>[
                                    PopupMenuItem(
                                      child: TextButton(
                                        onPressed: () {
                                          isEdit = true;
                                          addAddressProvider.fullNamecontroller
                                              .text = "${data.fullname}";
                                          addAddressProvider.cityControler
                                              .text = "${data.city}";
                                          addAddressProvider.landMarkControler
                                              .text = "${data.landMark}";
                                          addAddressProvider.numbercontroller
                                              .text = "${data.number}";
                                          addAddressProvider.pincodeControler
                                              .text = "${data.pincode}";
                                          addAddressProvider.streetcontroller
                                              .text = "${data.street}";

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddDelivaryAddress(
                                                        id: data.id),
                                              ));
                                          //
                                        },
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(color: Colors.amber),
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: TextButton(
                                        onPressed: () {
                                          deleteAddressDialgoue(data.id);
                                          //       // addAddressProvider.deleteAddress(data.id),
                                        },
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return PaymentScreen(
                                                name: allAddressData.fullname,
                                                number: allAddressData.number);
                                          }));
                                          //       // addAddressProvider.deleteAddress(data.id),
                                        },
                                        child: Text(
                                          "gg",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    )
                                  ];
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: 45,
          child: MaterialButton(
            color: backgroundcolor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              25,
            )),
            onPressed: () {
              addAddressProvider.getResultAddressDetails.isEmpty
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddDelivaryAddress(),
                      ))
                  : allAddressData = DelivaryAddressModel();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PaymentScreen(
                    name: allAddressData.fullname,
                    number: allAddressData.number);
              }));
            },
            child: addAddressProvider.getResultAddressDetails.isEmpty
                ? Text(
                    'Add Adress',
                    style: GoogleFonts.secularOne(
                      fontSize: 18,
                    ),
                  )
                : Text(
                    'Payment',
                    style: GoogleFonts.secularOne(
                      fontSize: 18,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  deleteAddressDialgoue(var delete) {
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
        await Provider.of<AddAddressController>(context, listen: false)
            .deleteAddress(delete);

        Navigator.pop(context);
        showSimpleNotification(
            Text(
              'Address removed',
              style: GoogleFonts.secularOne(fontSize: 20, color: Colors.amber),
            ),
            background: Colors.white,
            duration: const Duration(milliseconds: 300));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Are You Sure?"),
      content: const Text("Do you want to remove the address?"),
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
