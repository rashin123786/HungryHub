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
    return Scaffold();
  }
}
