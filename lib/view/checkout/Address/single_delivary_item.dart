import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/domain/constants/constants.dart';
import 'package:provider/provider.dart';

import '../../../controlls/check_out_controller.dart';

class SingleDelivaryItem extends StatelessWidget {
  const SingleDelivaryItem({
    super.key,
    this.name,
    this.street,
    this.landmark,
    this.number,
    this.city,
    this.pincode,
  });
  final String? name;
  final String? landmark;
  final String? number;
  final String? street;
  final String? city;
  final String? pincode;

  @override
  Widget build(BuildContext context) {
    final checkoutprovider = Provider.of<CheckOutController>(context);
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 8,
            backgroundColor: backgroundcolor,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 5,
              ),
              Text("+91 $number"),
              Text("$street,$landmark"),
              Text("$city,$pincode"),
            ],
          ),
        ),
        divider2,
      ],
    );
  }
}
