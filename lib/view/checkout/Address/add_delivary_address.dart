import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/domain/constants/constants.dart';
import 'package:provider/provider.dart';

import '../../../controlls/check_out_controller.dart';
import '../../widgets/text_form_field.dart';

class AddDelivaryAddress extends StatefulWidget {
  const AddDelivaryAddress({super.key});

  @override
  State<AddDelivaryAddress> createState() => _AddDelivaryAddressState();
}

final nameController = TextEditingController();

// enum AdressType { Home, Work, Other }
final _formkey = GlobalKey<FormState>();

class _AddDelivaryAddressState extends State<AddDelivaryAddress> {
  @override
  Widget build(BuildContext context) {
    final checkoutProvider = Provider.of<CheckOutController>(context);
    // var myType = AdressType.Home;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Delivary Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              ReUseTextFormsField(
                textInputType: TextInputType.text,
                controls: checkoutProvider.fullNamecontroller,
                hintText: 'Full Name',
                ispass: false,
                prefixIcons: Icon(
                  Icons.person,
                ),
                validator: (name) {
                  return name!.isEmpty ? 'Name is Empty' : null;
                },
              ),
              sizedboxHeight10,
              ReUseTextFormsField(
                textInputType: TextInputType.phone,
                controls: checkoutProvider.numbercontroller,
                hintText: 'Mobile No:',
                ispass: false,
                prefixIcons: Icon(
                  Icons.phone_enabled,
                ),
                validator: (p0) {
                  return p0!.isEmpty ? 'Mobile No: is Empty' : null;
                },
              ),
              sizedboxHeight10,
              ReUseTextFormsField(
                textInputType: TextInputType.streetAddress,
                controls: checkoutProvider.streetcontroller,
                hintText: 'Street',
                ispass: false,
                prefixIcons: Icon(
                  Icons.streetview,
                ),
                validator: (p0) {
                  return p0!.isEmpty ? 'Street is Empty' : null;
                },
              ),
              sizedboxHeight10,
              ReUseTextFormsField(
                textInputType: TextInputType.text,
                controls: checkoutProvider.landMarkControler,
                hintText: 'LandMark',
                ispass: false,
                prefixIcons: Icon(
                  Icons.landscape_sharp,
                ),
                validator: (p0) {
                  return p0!.isEmpty ? 'LandMark is Empty' : null;
                },
              ),
              sizedboxHeight10,
              ReUseTextFormsField(
                textInputType: TextInputType.text,
                controls: checkoutProvider.cityControler,
                hintText: 'City',
                ispass: false,
                prefixIcons: Icon(
                  Icons.location_city,
                ),
                validator: (p0) {
                  return p0!.isEmpty ? 'City is Empty' : null;
                },
              ),
              sizedboxHeight10,
              ReUseTextFormsField(
                textInputType: TextInputType.phone,
                controls: checkoutProvider.pincodeControler,
                hintText: 'pincode',
                ispass: false,
                prefixIcons: Icon(
                  Icons.lock,
                ),
                validator: (p0) {
                  return p0!.isEmpty ? 'Pincode is Empty' : null;
                },
              ),
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
            onPressed: () {
              _formkey.currentState!.validate();
              checkoutProvider.addAddress(context);
            },
            child: Text(
              'Submit',
              style: GoogleFonts.secularOne(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
