import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungryhub/domain/constants/constants.dart';
import 'package:hungryhub/domain/services/pizza_product.dart';

class PizzaScreen extends StatelessWidget {
  PizzaScreen({super.key});
  final _formkey = GlobalKey<FormState>();
  final searchPizzaControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            sizedboxHeight20,
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                  controller: searchPizzaControl,
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
                    fillColor: Colors.white,
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
            ),
            sizedboxHeight20,
            Center(
              child: Text(
                'Pizza',
                style: GoogleFonts.secularOne(
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
            StreamBuilder(
              stream: getPizzaStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GridView.builder(
                        itemCount: snapshot.data!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: (0.55 / 0.7),
                          crossAxisCount: 2,
                          crossAxisSpacing: 2,
                        ),
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];
                          return Card(
                            color: Colors.white,
                            shadowColor: backgroundcolor,
                            elevation: 15,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Image.network(
                                      data.productImage,
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                      height: height * 0.2,
                                    ),
                                    Positioned(
                                      left: width * 0.365,
                                      top: height * 0.15,
                                      child: CircleAvatar(
                                        radius: 24,
                                        backgroundColor: Colors.white,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.favorite,
                                              color: Colors.amber,
                                              size: 35,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                                Flexible(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      style: GoogleFonts.secularOne(
                                          fontSize: 20, color: Colors.black),
                                      text: "  ${data.productName}",
                                    ),
                                  ),
                                ),
                                Text(
                                  data.productRate,
                                  style: GoogleFonts.secularOne(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return Text('something went wrong');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
