import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hungryhub/domain/constants/constants.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "About us",
          style: menuscreen20,
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, bottom: 30, right: 10, left: 10),
        child: ListView(
          children: [
            Image.asset('assets/images/foodicon3.jpg'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ''' Welcome to Hungry Hub, the ultimate solution for all your food cravings! We are a team of passionate foodies who believe in making your dining experience convenient, fun, and unforgettable. With our user-friendly app and seamless services, we bring you the best food options from top-rated restaurants in your area.
            
At Hungry Hub, we understand how important it is for you to get your favorite food, delivered quickly and hassle-free. That's why we have partnered with a wide range of restaurants, cafes, and food joints to bring you a diverse menu that caters to all your preferences. From local delights to international cuisines, we have it all covered!

Our app is designed to make your food ordering experience as smooth as possible. With a few clicks, you can browse through different menus, place an order, and track its progress in real-time. Our integrated map feature allows you to locate nearby restaurants, check their reviews, and get directions to their physical location.

We are committed to providing excellent customer service and ensuring your satisfaction with every order. Our team works round the clock to make sure your food is prepared to perfection and delivered to you on time. Whether you're at home, work, or on the go, we have got you covered!

Thank you for choosing Hungry Hub as your go-to food ordering app. We appreciate your support and look forward to serving you delicious meals, anytime, anywhere!''',
                style: TextStyle(fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
