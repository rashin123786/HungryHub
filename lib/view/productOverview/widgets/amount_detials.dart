import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/constants/constants.dart';

class ProductOverViewAmount extends StatelessWidget {
  const ProductOverViewAmount({
    super.key,
    required this.leftText,
    required this.rightText,
  });
  final String leftText;
  final String rightText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText,
          style: GoogleFonts.secularOne(
            fontSize: 18,
          ),
        ),
        Text(
          rightText,
          softWrap: true,
          style: GoogleFonts.secularOne(
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
