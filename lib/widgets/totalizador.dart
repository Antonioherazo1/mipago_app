import 'package:flutter/material.dart';

class Totalizador extends StatelessWidget {
  final int total;

  Totalizador({this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Total Pago:  \$ ',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
          Text('$total',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
