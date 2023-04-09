// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/domain/constants/constants.dart';
import 'package:hungryhub/view/checkout/Address/delivary_details.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../../../controlls/check_out_controller.dart';
import '../../../controlls/add_address.dart';
import '../../widgets/text_form_field.dart';

class AddDelivaryAddress extends StatefulWidget {
  String? id;
  AddDelivaryAddress({
    super.key,
    this.id,
  });

  @override
  State<AddDelivaryAddress> createState() => _AddDelivaryAddressState();
}

final _formkey = GlobalKey<FormState>();

class _AddDelivaryAddressState extends State<AddDelivaryAddress> {
  @override
  Widget build(BuildContext context) {
    final addAddressProvider = Provider.of<AddAddressController>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Delivary Address'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Form(
            key: _formkey,
            child: ListView(
              children: [
                ReUseTextFormsField(
                  textInputType: TextInputType.text,
                  controls: addAddressProvider.fullNamecontroller,
                  hintText: 'Full Name',
                  ispass: false,
                  prefixIcons: Icon(
                    Icons.person,
                  ),
                  validator: (name) => name!.isEmpty ? 'Name is Empty' : null,
                ),
                sizedboxHeight10,
                ReUseTextFormsField(
                  textInputType: TextInputType.phone,
                  controls: addAddressProvider.numbercontroller,
                  hintText: 'Mobile No:',
                  ispass: false,
                  prefixIcons: Icon(
                    Icons.phone_enabled,
                  ),
                  validator: (number) =>
                      number!.isEmpty ? 'Mobile No: is Empty' : null,
                ),
                sizedboxHeight10,
                ReUseTextFormsField(
                  textInputType: TextInputType.streetAddress,
                  controls: addAddressProvider.streetcontroller,
                  hintText: 'Street',
                  ispass: false,
                  prefixIcons: Icon(
                    Icons.streetview,
                  ),
                  validator: (street) =>
                      street!.isEmpty ? 'Street is Empty' : null,
                ),
                sizedboxHeight10,
                ReUseTextFormsField(
                  textInputType: TextInputType.text,
                  controls: addAddressProvider.landMarkControler,
                  hintText: 'LandMark',
                  ispass: false,
                  prefixIcons: Icon(
                    Icons.landscape_sharp,
                  ),
                  validator: (landMark) =>
                      landMark!.isEmpty ? 'LandMark is Empty' : null,
                ),
                sizedboxHeight10,
                ReUseTextFormsField(
                  textInputType: TextInputType.text,
                  controls: addAddressProvider.cityControler,
                  hintText: 'City',
                  ispass: false,
                  prefixIcons: Icon(
                    Icons.location_city,
                  ),
                  validator: (city) => city!.isEmpty ? 'City is Empty' : null,
                ),
                sizedboxHeight10,
                ReUseTextFormsField(
                    textInputType: TextInputType.phone,
                    controls: addAddressProvider.pincodeControler,
                    hintText: 'pincode',
                    ispass: false,
                    prefixIcons: const Icon(
                      Icons.lock,
                    ),
                    validator: (pincode) =>
                        pincode!.isEmpty ? 'Pincode is Empty' : null),
                sizedboxHeight10,
                divider,
                InkWell(
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    height: 45,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add Location",
                          style: GoogleFonts.secularOne(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                divider2,
              ],
            ),
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
              onPressed: isEdit == false
                  ? () async {
                      if (_formkey.currentState!.validate()) {
                        addAddressProvider.addAddress();
                        addAddressProvider.clearText();
                        //  checkoutProvider.addAddress(context);
                        showSimpleNotification(
                            Text(
                              'Addeed Address',
                              style: GoogleFonts.secularOne(
                                  fontSize: 20, color: Colors.amber),
                            ),
                            background: Colors.white,
                            duration: const Duration(milliseconds: 300));
                        //   checkoutProvider.clearText();
                        Navigator.pop(context);
                      }
                    }
                  : () async {
                      await addAddressProvider.updateAddress(widget.id);
                      addAddressProvider.clearText();
                      Navigator.pop(context);
                    },
              child: isEdit == false
                  ? Text(
                      'Submit',
                      style: GoogleFonts.secularOne(
                        fontSize: 18,
                      ),
                    )
                  : Text(
                      'Update',
                      style: GoogleFonts.secularOne(
                        fontSize: 18,
                      ),
                    ),
            ),
          ),
        ));
  }
}
