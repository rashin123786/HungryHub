import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hungryhub/view/settings/about_us.dart';
import 'package:hungryhub/view/settings/privacy_policy.dart';
import 'package:hungryhub/view/settings/terms_and_condition.dart';
import '../../domain/constants/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return IconButton(
        // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
        icon: FaIcon(FontAwesomeIcons.gamepad),
        onPressed: () {
          print("Pressed");
        });
  }
}

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Settings",
          style: menuscreen20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              shadowColor: backgroundcolor,
              elevation: 15,
              child: ListTile(
                title: Text(
                  "Privacy Policy",
                  style: menuscreen20,
                ),
                trailing: Icon(
                  Icons.forward_sharp,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivacyPolicy(),
                      ));
                },
              ),
            ),
            sizedboxHeight20,
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              shadowColor: backgroundcolor,
              elevation: 15,
              child: ListTile(
                title: Text(
                  "Terms & condtions",
                  style: menuscreen20,
                ),
                trailing: Icon(
                  Icons.forward_sharp,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TermsAndCondition(),
                      ));
                },
              ),
            ),
            sizedboxHeight20,
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              shadowColor: backgroundcolor,
              elevation: 15,
              child: ListTile(
                title: Text(
                  "About us",
                  style: menuscreen20,
                ),
                trailing: Icon(
                  Icons.forward_sharp,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutUs(),
                      ));
                },
              ),
            ),
            sizedboxHeight50,
            sizedboxHeight50,
            sizedboxHeight50,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    launchUrl(
                      Uri.parse(
                        "https://instagram.com/rashieey.__?igshid=ZDdkNTZiNTM=",
                      ),
                    );
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Colors.amber,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    launchUrl(
                      Uri.parse(
                        "https://github.com/rashin123786",
                      ),
                    );
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.github,
                    color: Colors.amber,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      launchUrl(
                        Uri.parse(
                          "https://www.linkedin.com/in/rashin-k-50b2681a7/",
                        ),
                      );
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.linkedin,
                      color: Colors.amber,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
