import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hungryhub/UI/authentication/view/sign_in.dart';
import 'package:hungryhub/domain/constants/constants.dart';
import 'package:provider/provider.dart';
import '../../../controlls/authentication.dart';
import '../../../domain/widgets/text_form_field.dart';
import '../authenticate.dart';

final TextEditingController usernamecontrol = TextEditingController();
final TextEditingController emailcontrol = TextEditingController();
final TextEditingController passwordcontrol = TextEditingController();

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authpProvider =
        Provider.of<GoogleSignInProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 235, 218, 1),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const Text(
                  'Sign Up to continue',
                  style: TextStyle(fontSize: 25),
                ),
                sizedboxHeight50,
                ReUseTextFormsField(
                  validator: (username) =>
                      username!.isEmpty ? 'Enter usename' : null,
                  controls: usernamecontrol,
                  ispass: false,
                  hintText: 'Enter Username',
                  prefixIcons: const Icon(
                    Icons.person,
                  ),
                ),
                sizedboxHeight10,
                ReUseTextFormsField(
                  validator: (email) =>
                      email!.isEmpty && !EmailValidator.validate(email)
                          ? 'Enter valid Email'
                          : null,
                  controls: emailcontrol,
                  ispass: false,
                  hintText: 'Enter email',
                  prefixIcons: const Icon(
                    Icons.email_sharp,
                  ),
                ),
                sizedboxHeight10,
                ReUseTextFormsField(
                  validator: (pass) => pass!.isEmpty && pass.length < 6
                      ? 'Enter min. 6 character'
                      : null,
                  controls: passwordcontrol,
                  ispass: true,
                  hintText: 'Enter password',
                  prefixIcons: const Icon(
                    Icons.lock,
                  ),
                ),
                sizedboxHeight20,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 227, 227),
                  ),
                  onPressed: () async {
                    _formkey.currentState!.validate();
                    await authpProvider.signUp(context);
                    //  clearstextfeild();
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  child: const Text(
                    "Already have an account?Sign In",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignIn(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

void clearstextfeild() {
  FocusManager.instance.primaryFocus?.unfocus();
  usernamecontrol.clear();
  passwordcontrol.clear();
  emailcontrol.clear();
}
