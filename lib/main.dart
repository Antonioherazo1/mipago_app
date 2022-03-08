import 'package:flutter/material.dart';
import 'package:mi_pago/screens/pantallaInicio.dart';
import 'package:provider/provider.dart';
import 'package:mi_pago/models/itemData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemData(),
      child: MaterialApp(
        home: PantallaInicio(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
