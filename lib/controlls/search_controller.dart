import 'package:flutter/cupertino.dart';
import 'package:hungryhub/domain/services/sandwich._product.dart';
import 'package:hungryhub/model/all_product_model.dart.dart';

import '../domain/services/burger_product.dart';
import '../domain/services/pizza_product.dart';

class SearchControll with ChangeNotifier {
  Stream<List<AllProductDetails>>? burgerstream;
  Stream<List<AllProductDetails>>? pizzastream;
  Stream<List<AllProductDetails>>? sandwichstream;
  bool istap = false;
  onTapButton() {
    istap = true;
    //  istap = false;
    notifyListeners();
  }

  void onChangeButtonBurger(value) {
    burgerstream = searchBurger(value);
    notifyListeners();
  }

  void onChangeButtonPizza(value) {
    pizzastream = searchPizza(value);
    notifyListeners();
  }

  void onChangeButtonSanwich(value) {
    sandwichstream = searchSandwich(value);
    notifyListeners();
  }
}
