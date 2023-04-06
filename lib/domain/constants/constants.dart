import 'package:flutter/material.dart';

import '../../model/all_product_model.dart.dart';

SizedBox sizedboxHeight10 = const SizedBox(
  height: 10,
);

SizedBox sizedboxHeight20 = const SizedBox(
  height: 20.0,
);

SizedBox sizedboxHeight50 = const SizedBox(
  height: 50.0,
);

List<String> images = [
  "https://www.dominos.co.in/great-deals/online-pizza-coupons/images/story_images/evd/evd-99.jpg",
  "https://t3.ftcdn.net/jpg/02/55/42/50/360_F_255425068_CyDrGsVcu1Bl2SdJ2yXx35Rlp8jyNCCQ.jpg",
  "https://us.123rf.com/450wm/plateresca/plateresca2004/plateresca200400237/145911391-a-panorama-of-a-burger-with-beef-cheese-onion-tomato-and-green-salad-a-side-view-on-a-dark.jpg?ver=6",
  "https://c4.wallpaperflare.com/wallpaper/197/854/431/fire-burger-5k-steak-wallpaper-preview.jpg",
  "https://www.dominos.co.in/great-deals/online-pizza-coupons/images/story_images/evd/evd-99.jpg",
  "https://t3.ftcdn.net/jpg/02/55/42/50/360_F_255425068_CyDrGsVcu1Bl2SdJ2yXx35Rlp8jyNCCQ.jpg",
  "https://us.123rf.com/450wm/plateresca/plateresca2004/plateresca200400237/145911391-a-panorama-of-a-burger-with-beef-cheese-onion-tomato-and-green-salad-a-side-view-on-a-dark.jpg?ver=6",
  "https://c4.wallpaperflare.com/wallpaper/197/854/431/fire-burger-5k-steak-wallpaper-preview.jpg",
];

// ------------------colors-----------------------------------//

Color backgroundcolor = const Color.fromRGBO(255, 199, 0, 1);

late AllProductDetails allDatas;

bool isOffer = true;
int? isCategory;

Divider divider = const Divider();
Divider divider2 = const Divider(
  thickness: 2,
);
