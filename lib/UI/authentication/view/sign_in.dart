import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hungryhub/UI/authentication/view/signup.dart';
import 'package:hungryhub/domain/widgets/text_form_field.dart';

import '../authenticate.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 235, 218, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 150),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const Text(
                    'Login In to continue',
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ReUseTextFormsField(
                      validator: (email) =>
                          email!.isEmpty && !EmailValidator.validate(email)
                              ? 'Enter valid Email'
                              : null,
                      controls: emailcontrol,
                      prefixIcons: const Icon(Icons.person),
                      hintText: 'Enter Email',
                      ispass: false),
                  const SizedBox(
                    height: 10,
                  ),
                  ReUseTextFormsField(
                      validator: (pass) => pass!.isEmpty && pass.length < 6
                          ? 'Enter min. 6 character'
                          : null,
                      controls: passwordcontrol,
                      prefixIcons: const Icon(Icons.lock),
                      hintText: 'Enter password',
                      ispass: true),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 227, 227),
                    ),
                    onPressed: () async {
                      _formkey.currentState!.validate();
                      await sigIn(context);
                      clearstextfeild();
                    },
                    child: const Text(
                      'Login In',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    child: const Text(
                      "Dont't have account?Sign Up",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
