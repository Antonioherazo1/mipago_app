import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mi_pago/screens/home.dart';

class PantallaInicio extends StatefulWidget {
  PantallaInicio({Key key}) : super(key: key);

  @override
  _PantallaInicioState createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreem(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 80,
          ),
          Container(
            padding: EdgeInsets.all(50.0),
            child: Center(
              child: Image.asset('images/logo_miPago.png'),
            ),
          ),
          Text(
            'Esta es una aplicación desarrollada por \n Antonio Herazo',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[500]),
          ),
          Container(
            margin: EdgeInsets.all(60),
            width: double.infinity,
            child: Text(
              'Version 1.0 \n Gratuita',
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.grey[500]),
            ),
          ),
          //SpinKitThreeBounce(
          //color: Colors.blueAccent,
          //size: 30.0,
          //),
        ],
      ),
    );
  }
}
