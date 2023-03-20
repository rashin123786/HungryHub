import 'package:flutter/material.dart';

final mainControll = TextEditingController();

// ignore: must_be_immutable
class ReUseTextFormsField extends StatelessWidget {
  ReUseTextFormsField({
    super.key,
    required this.prefixIcons,
    required this.hintText,
    required this.ispass,
    required this.controls,
    required this.validator,
  });
  final Widget prefixIcons;
  final String hintText;
  final bool ispass;
  var controls = mainControll;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      controller: controls,
      obscureText: ispass,
      decoration: InputDecoration(
        prefixIcon: prefixIcons,
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              40,
            ),
          ),
        ),
      ),
      onTap: () {},
    );
  }
}
