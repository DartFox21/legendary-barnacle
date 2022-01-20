import 'package:flutter/material.dart';

class NavBarLogo extends StatelessWidget {
  const NavBarLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        textBaseline: TextBaseline.alphabetic,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            child: Image.asset('images/chromelogo.png'),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('GoDart',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Airbnb Cereal Bold')),
          )
        ],
      ),
    );
  }
}
