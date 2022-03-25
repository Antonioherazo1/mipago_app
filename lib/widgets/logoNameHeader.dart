import 'package:flutter/material.dart';

class LogoNameWidget extends StatelessWidget {
  const LogoNameWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.0,
      height: 70.0,
      //width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Container(
            child: Center(child: Image.asset('images/logo_miPago.png')),
            margin: EdgeInsets.all(5.0),
          ),
          Expanded(
            child: Center(
              child: Text(
                'miPago',
                style: new TextStyle(fontSize: 40, fontFamily: 'Dalgona'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
