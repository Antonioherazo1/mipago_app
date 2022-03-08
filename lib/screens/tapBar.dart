import 'package:flutter/material.dart';
import 'package:mi_pago/screens/balance.dart';
import 'package:mi_pago/screens/egresos.dart';
import 'package:mi_pago/screens/ingresos.dart';

class TapBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'miPago',
            style: TextStyle(fontFamily: 'Dalgona'),
          ),
          bottom: TabBar(tabs: <Widget>[
            Tab(
              icon: Icon(Icons.add, size: 50.0),
            ),
            Tab(
              icon: Icon(Icons.remove, size: 50.0),
            ),
            Tab(
              icon: Icon(Icons.drag_handle, size: 50.0),
            ),
          ]),
        ),
        body: TabBarView(
            children: <Widget>[Ingresos(), Egresos(), BalanceGeneral()]),
      ),
    );
  }
}
