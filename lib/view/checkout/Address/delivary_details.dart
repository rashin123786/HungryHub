import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/controlls/check_out_controller.dart';

import 'package:hungryhub/domain/constants/constants.dart';
import 'package:hungryhub/model/address_model.dart';
import 'package:hungryhub/view/checkout/Address/add_delivary_address.dart';
import 'package:hungryhub/view/checkout/Address/single_delivary_item.dart';
import 'package:provider/provider.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutProvider = Provider.of<CheckOutController>(context);
    checkoutProvider.getAddress();

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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddDelivaryAddress(),
              ));
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: ListView(
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
            checkoutProvider.delivaryAddressListResult.isEmpty
                ? Center(
                    child: Text('No Data'),
                  )
                : Column(
                    children:
                        checkoutProvider.delivaryAddressListResult.map((e) {
                      return SingleDelivaryItem(
                        address: e.City,
                        name: e.fullname,
                        number: e.number,
                        street: e.street,
                      );
                    }).toList(),
                  )
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
              checkoutProvider.allDelivaryDetails.isEmpty
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddDelivaryAddress(),
                      ))
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddressDetails(),
                      ));
            },
            child: checkoutProvider.delivaryAddressListResult.isEmpty
                ? Text(
                    'Add Adress',
                    style: GoogleFonts.secularOne(
                      fontSize: 18,
                    ),
                  )
                : Text(
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
