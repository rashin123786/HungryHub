import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../../controller/authentication.dart';
import '../../controller/constants/constants.dart';
import '../widgets/text_form_field.dart';

final forgotpasscontrol = TextEditingController();

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundcolor,
        centerTitle: true,
        title: const Text(
          'Forgot Password',
        ),
      ),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/forgotpass1.png',
                  ),
                  fit: BoxFit.contain),
            ),
          ),
          sizedboxHeight50,
          Text(
            '  Please Enter Your Email Address To\n  Recieve a Verication Link',
            style: GoogleFonts.roboto(fontSize: 18),
          ),
          sizedboxHeight10,
          ReUseTextFormsField(
              textInputType: TextInputType.emailAddress,
              validator: (email) =>
                  email!.isEmpty && !EmailValidator.validate(email)
                      ? 'Enter valid Email'
                      : null,
              controls: forgotpasscontrol,
              prefixIcons: const Icon(Icons.email),
              hintText: 'Enter Email',
              ispass: false),
          sizedboxHeight10,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundcolor,
            ),
            onPressed: () async {
              Provider.of<AuthenticateProvider>(context, listen: false)
                  .forgotPassword(context);
            },
            child: const Text(
              'send',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      )),
    );
  }
}
