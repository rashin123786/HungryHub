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
    this.address,
    this.number,
  });
  final String? name;
  final String? address;
  final String? number;
  final String? street;

  @override
  Widget build(BuildContext context) {
    final checkoutProvider = Provider.of<CheckOutController>(context);

    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name ?? '',
                style: GoogleFonts.secularOne(
                  fontSize: 18,
                ),
              ),
              Container(
                width: 60,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.amber,
                ),
                child: Center(
                  child: Text(
                    street ?? '',
                  ),
                ),
              ),
            ],
          ),
          leading: CircleAvatar(
            radius: 8,
            backgroundColor: backgroundcolor,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(address ?? ''),
              SizedBox(
                height: 5,
              ),
              Text(number ?? ''),
            ],
          ),
        ),
        divider2,
      ],
    );
  }
}
