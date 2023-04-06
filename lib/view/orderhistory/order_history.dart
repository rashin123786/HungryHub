import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hungryhub/domain/services/burger_product.dart';
import 'package:hungryhub/model/all_product_model.dart.dart';
import 'package:hungryhub/view/category/Burger/burger_screen.dart';
import 'package:provider/provider.dart';

import '../../controlls/search_controller.dart';
import '../../domain/constants/constants.dart';
import '../widgets/wish_list_button.dart';

class OrderHistory extends StatelessWidget {
  OrderHistory({super.key});

  TextEditingController searchController = TextEditingController();

  // Future<List<AllProductDetails>> searchItem(String searchtext) async {
  Stream<List<AllProductDetails>>? burgerstream;

  // void onSearchChanged(String query) {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchProvider = Provider.of<SearchControll>(context);
    final height = size.height;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TextButton(
              onPressed: () {
                // String query = "pan";
                // Stream<List<AllProductDetails>> burgertree =
                //     getBurgerStreams(query);
                // print(burgertree);
              },
              child: const Text('click me')),
          TextFormField(
            onChanged: (value) {
              searchProvider.onChangeButtonBurger(value);
              // print(value);
              searchController.clear();
              // searchItem(value).then((result) {
              //   setState(() {
              //     searchResults = result;
              //   });
              // });
            },
            controller: searchController,
            validator: (value) => value!.isEmpty ? 'Please Enter a Name' : null,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () async {
                  //  _formkey.currentState!.validate();
                  // searchItem(searchController.text);
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
          Expanded(
              child: StreamBuilder(
            stream: searchProvider.burgerstream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (0.45 / 0.55),
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final datare = snapshot.data![index];

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.white,
                      shadowColor: backgroundcolor,
                      elevation: 15,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(21.0),
                                child: Image.network(
                                  datare.productImage,
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: height * 0.2,
                                ),
                              ),
                              WishListButton(
                                id: datare.id,
                                productImage: datare.productImage,
                                productName: datare.productName,
                                productRate: datare.productRate,
                                productDescription: datare.productDescription,
                                productTime: datare.productTime,
                              ),
                            ],
                          ),
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: GoogleFonts.secularOne(
                                    fontSize: 20, color: Colors.black),
                                text: "  ${datare.productName}",
                              ),
                            ),
                          ),
                          Text(
                            "₹${datare.productRate}",
                            style: GoogleFonts.secularOne(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return BurgerScreen();
              }
            },
          )),
        ],
      )),
    );
  }
}
