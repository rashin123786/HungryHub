import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

import 'package:hungryhub/view/Home/home.dart';
import 'package:hungryhub/view/cart/cart.dart';
import 'package:hungryhub/view/wishlist/wish_list.dart';
import 'package:provider/provider.dart';
import '../../controlls/bottom_nav_controler.dart';
import '../../domain/constants/constants.dart';
import '../orderhistory/order_history.dart';

class BottomNav extends StatelessWidget {
  BottomNav({super.key});

  final pages = [
    HomeScreen(),
    WishListScreen(),
    const OrderHistory(),
  ];

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
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.home, title: "Home"),
            TabData(iconData: Icons.favorite_rounded, title: "WishList"),
            TabData(iconData: Icons.history_rounded, title: "OrderHistory")
          ],
          activeIconColor: backgroundcolor,
          barBackgroundColor: backgroundcolor,
          circleColor: Colors.white,
          textColor: Colors.white,
          onTabChangedListener: (position) {
            Provider.of<BottomNavController>(context, listen: false)
                .bottomSwitch(position);
          },
        ));
  }
}
