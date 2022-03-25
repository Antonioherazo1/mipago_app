import 'package:flutter/material.dart';
import 'package:mi_pago/models/itemData.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mi_pago/screens/home.dart';
import 'package:provider/provider.dart';

class PantallaInicio extends StatefulWidget {
  PantallaInicio({Key key}) : super(key: key);

  @override
  _PantallaInicioState createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {



  @override
  void initState() {
    super.initState();
    Provider.of<ItemData>(context, listen: false).getValorUnitarioSF();
    Provider.of<ItemData>(context, listen: false).getHorasPorCicloSF();
    Provider.of<ItemData>(context, listen: false).getItemList();


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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
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
            ],
          ),
        ),
      ),
    );
  }
}
