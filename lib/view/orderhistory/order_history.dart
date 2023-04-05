import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hungryhub/controlls/search_controller.dart';
import 'package:hungryhub/domain/constants/constants.dart';
import 'package:hungryhub/domain/services/burger_product.dart';
import 'package:hungryhub/model/all_product_model.dart.dart';
import 'package:provider/provider.dart';

import '../category/Burger/burger_screen.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  TextEditingController searchController = TextEditingController();
  List<AllProductDetails> searchResults = [];

  // Future<List<AllProductDetails>> searchItem(String searchtext) async {
  //   final snapshot = await FirebaseFirestore.instance
  //       .collection('burgers')
  //       .where('productName', isEqualTo: searchtext)
  //       .get();
  //   return snapshot.docs.map((e) {
  //     return AllProductDetails.fromjson(e.data());
  //   }).toList();
  // }
  Stream<List<AllProductDetails>>? burgerstream;

  // void onSearchChanged(String query) {
  //   setState(() {
  //     burgerstream = getBurgerStreams(query);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
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
              child: Text('click me')),
          TextFormField(
            onChanged: (value) {
              setState(() {
                burgerstream = SearchBurger(value);
                //  onSearchChanged(value);
              });
              // print(value);

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
            stream: burgerstream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final datare = snapshot.data![index];
                    print(datare.productName);
                    return Text(datare.productName);
                  },
                );
              } else {
                return Text(snapshot.error.toString());
              }
            },
          )),
        ],
      )),
    );
  }
}
