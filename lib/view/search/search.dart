import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hungryhub/model/all_product_model.dart.dart';

class SearchScreen extends StatefulWidget {
  final List<AllProductDetails>? search;
  const SearchScreen({super.key, this.search});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formkey = GlobalKey<FormState>();
  String query = "";
  final searchBurgerControl = TextEditingController();

  List<AllProductDetails> serachItem(String query) {
    List<AllProductDetails> searchFood = widget.search!.where((element) {
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    List<AllProductDetails> _searchItems = serachItem(query);
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text("items"),
          ),
          Container(
            height: 52,
            child: Form(
              key: _formkey,
              child: TextFormField(
                onChanged: (value) {
                  print(value);
                  setState(() {
                    query = value;
                  });
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
          )
        ],
      ),
    );
  }
}
