// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:hungryhub/controller/constants/constants.dart';
import 'package:hungryhub/controller/provider/search_controller.dart';
import 'package:hungryhub/view/widgets/wish_list_button.dart';

import 'package:hungryhub/view/search/search_widget.dart';
import 'package:provider/provider.dart';

import '../../../controller/services/burger_product.dart';
import '../../../model/all_product_model.dart.dart';
import '../../productOverview/product_overview.dart';

class BurgerScreen extends StatelessWidget {
  BurgerScreen({super.key});

  final _formkey = GlobalKey<FormState>();

  final searchBurgerControl = TextEditingController();

  bool istap = false;

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchControll>(context);
    final size = MediaQuery.of(context).size;

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
                child: GestureDetector(
                  child: TextFormField(
                    onChanged: (value) {
                      istap = true;
                      searchProvider.onChangeButtonBurger(value);
                    },
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
            ),
            sizedboxHeight20,
            Center(
              child: Text(
                'Burgers',
                style: GoogleFonts.secularOne(
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
            istap == false
                ? StreamBuilder(
                    stream: getBurgerStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
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
                                  childAspectRatio: (0.45 / 0.55),
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 2,
                                ),
                                itemBuilder: (context, index) {
                                  final data = snapshot.data![index];
                                  return GestureDetector(
                                    onTap: () async {
                                      isOffer = true;
                                      allDatas = AllProductDetails(
                                        id: data.id,
                                        productImage: data.productImage,
                                        productName: data.productName,
                                        productRate: data.productRate,
                                        productDescription:
                                            data.productDescription,
                                        productTime: data.productTime,
                                      );
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ProductOverView(),
                                          ));
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: Colors.white,
                                      shadowColor: backgroundcolor,
                                      elevation: 15,
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(21.0),
                                                child: Image.network(
                                                  data.productImage,
                                                  fit: BoxFit.fill,
                                                  width: double.infinity,
                                                  height: height * 0.2,
                                                ),
                                              ),
                                              WishListButton(
                                                id: data.id,
                                                productImage: data.productImage,
                                                productName: data.productName,
                                                productRate: data.productRate,
                                                productDescription:
                                                    data.productDescription,
                                                productTime: data.productTime,
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                style: GoogleFonts.secularOne(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                text: "  ${data.productName}",
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "₹${data.productRate}",
                                            style: GoogleFonts.secularOne(
                                              fontSize: 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )),
                        );
                      } else {
                        return const Text('Something went wrong');
                      }
                    },
                  )
                : SearchWidget(searchStream: searchProvider.burgerstream)
          ],
        ),
      ),
    );
  }
}
