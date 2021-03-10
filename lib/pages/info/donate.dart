import 'package:flutter/material.dart';

class DonatePage extends StatefulWidget {
  @override
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Donate",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  AssetImage('lib/assets/images/G-PAY(SUNAAD).png'),
              radius: 32.0,
            ),
            CircleAvatar(
              backgroundImage:
                  AssetImage('lib/assets/images/PAYTM(SUNAAD).png'),
              radius: 32.0,
            ),
          ],
        ));
  }
}
