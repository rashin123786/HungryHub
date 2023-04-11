import 'package:flutter/material.dart';

enum PaymentType { cod, onlinepayment }

class PaymentController with ChangeNotifier {
  PaymentType myType = PaymentType.cod;
  PaymentType get myPay => myType;

  void checkPymentMethod(PaymentType value) {
    myType = value;
    notifyListeners();
  }
}
