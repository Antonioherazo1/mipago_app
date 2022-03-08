import 'package:flutter/material.dart';
import 'package:mi_pago/widgets/addNewItemButtom.dart';
import 'package:mi_pago/widgets/itemList.dart';
import 'package:mi_pago/models/itemModel.dart';

// ignore: must_be_immutable
class Ingresos extends StatefulWidget {
  List<ItemModel> incomeList;

  @override
  _IngresosState createState() => _IngresosState();
}

class _IngresosState extends State<Ingresos> {
  var txt = TextEditingController();
  var txt2 = TextEditingController();
  int valueUnitar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Ingresos',
            // style: TextStyle(fontFamily: 'Dalgona'),
          ),
          automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Column(
          children: [ItemList(income: true), AddNewItemButtom(tipo: 'INGRESO')],
        ),
      ),
    );
  }
}
