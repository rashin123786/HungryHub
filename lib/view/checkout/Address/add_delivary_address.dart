// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:hungryhub/controller/constants/constants.dart';
import 'package:hungryhub/view/checkout/Address/delivary_details.dart';
import 'package:hungryhub/view/checkout/Address/google_map.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../../../controller/provider/add_address.dart';
import '../../widgets/text_form_field.dart';

class AddDelivaryAddress extends StatelessWidget {
  String? id;
  AddDelivaryAddress({
    super.key,
    this.id,
  });

  final _formkey = GlobalKey<FormState>();
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
                  prefixIcons: const Icon(
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
                  prefixIcons: const Icon(
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
                  prefixIcons: const Icon(
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
                  prefixIcons: const Icon(
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
                  prefixIcons: const Icon(
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
                Center(
                  child: Text(
                    "Or",
                    style: menuscreen20,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GoogleMapScreen(),
                        ));
                  },
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

                        showSimpleNotification(
                            Text(
                              'Addeed Address',
                              style: GoogleFonts.secularOne(
                                  fontSize: 20, color: Colors.amber),
                            ),
                            background: Colors.white,
                            duration: const Duration(milliseconds: 300));

                        Navigator.pop(context);
                      }
                    }
                  : () async {
                      await addAddressProvider.updateAddress(id);
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
