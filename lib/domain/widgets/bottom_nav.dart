import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:hungryhub/UI/Home/home.dart';
import 'package:hungryhub/UI/cart/cart.dart';
import 'package:hungryhub/UI/wishlist/wish_list.dart';
import 'package:provider/provider.dart';

import '../../controlls/bottom_nav_controler.dart';

class BottomNav extends StatelessWidget {
  BottomNav({super.key});

  final pages = [
    HomeScreen(),
    CartScreen(),
    WishListScreen(),
  ];
  final int _currentSelectedIndex = 0;
  List<TabItem> tabItems = List.of([
    TabItem(Icons.home, "Home", Colors.blue,
        labelStyle: TextStyle(fontWeight: FontWeight.normal)),
    TabItem(Icons.search, "Search", Colors.orange,
        labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    TabItem(Icons.layers, "Reports", Colors.red,
        circleStrokeColor: Colors.black),
  ]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavController>(
        builder: (context, value, child) {
          return PageView(
            children: [pages[value.currentindex]],
          );
        },
      ),
      bottomNavigationBar: CircularBottomNavigation(
        tabItems,
        selectedPos: _currentSelectedIndex,
        selectedCallback: (selectedPos) {
          Provider.of<BottomNavController>(context, listen: false)
              .bottomSwitch(selectedPos);
        },
      ),
    );
  }
}
