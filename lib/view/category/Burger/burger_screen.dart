import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/domain/constants/constants.dart';
import 'package:hungryhub/view/widgets/text_form_field.dart';

import '../../../domain/services/burger_product.dart';

final searchBurgerControl = TextEditingController();

class BurgerScreen extends StatelessWidget {
  BurgerScreen({super.key});
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Burgers',
                  style: GoogleFonts.secularOne(
                    fontSize: 25,
                    color: Colors.amber,
                  ),
                ),
              ),
              sizedboxHeight20,
              Form(
                key: _formkey,
                child: TextFormField(
                  controller: searchBurgerControl,
                  validator: (value) =>
                      value!.isEmpty ? 'Please Enter a Name' : null,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        _formkey.currentState!.validate();

                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                    fillColor: Colors.grey,
                    hintText: 'Search here...',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              sizedboxHeight20,
              StreamBuilder(
                stream: getBurgerStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];
                          return Card(
                            elevation: 15,
                            shadowColor: Colors.black,
                            child: Container(
                              color: Color.fromARGB(255, 255, 191, 0),
                              width: double.infinity,
                              height: 120,
                              child: Row(
                                children: [
                                  Container(
                                    width: 140,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          data.productImage,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Flexible(
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            style: GoogleFonts.secularOne(
                                                fontSize: 15,
                                                color: Colors.black),
                                            text: "  ${data.productName}",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: snapshot.data!.length,
                      ),
                    );
                  } else {
                    return const Text('Something went wrong');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
