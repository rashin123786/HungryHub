import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/all_product_model.dart.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  String searchQuery = '';
  StreamController<QuerySnapshot> controller =
      StreamController<QuerySnapshot>.broadcast();

  List<AllProductDetails> allfood = [];

  void foundsss(String texts) async {
    final result = await FirebaseFirestore.instance
        .collection('burgers')
        .where('productName', isEqualTo: texts)
        .get();
    setState(() {
      allfood = result.docs.map((e) {
        return AllProductDetails.fromjson(e.data());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              foundsss(value);
            },
            validator: (value) => value!.isEmpty ? 'Please Enter a Name' : null,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () async {
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
              child: ListView.builder(
            itemCount: allfood.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(allfood[index].productName),
              );
            },
          ))
        ],
      )),
    );
  }
}
