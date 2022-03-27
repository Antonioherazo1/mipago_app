import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mi_pago/models/itemData.dart';

class DroppDownSubTypeItem extends StatefulWidget {

  //final Function updateScreen;
  //DroppDownSubTypeItem({this.updateScreen});

  @override
  _DroppDownSubTypeItemState createState() => _DroppDownSubTypeItemState();
}

class _DroppDownSubTypeItemState extends State<DroppDownSubTypeItem> {
  List<String> subTypeItem = [
    'Cantidad Fija',
    'Fracción Ingresos\ndel ciclo',
    'Fracción Ingresos\nmensuales Exedidos'];

  String valueChoosen;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '''TIPO\nEGRESO:''',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          DropdownButton(
            hint: Text('Elige una opcion'),
            //---------------------
            value: valueChoosen,
            //---------------------
            items: subTypeItem.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Container(
                  width: 150.0,
                  child: Text(valueItem),
                ),
              );
            }).toList(),
            //---------------------
            onChanged: (newValue) {
              //widget.updateScreen();
              setState(() {
                Provider.of<ItemData>(context, listen: false).subTypeItem = newValue;
                Provider.of<ItemData>(context, listen: false).notifylisteners();
                valueChoosen = newValue;
              });
            },
            //---------------------
          ),
        ],
      ),
    );
  }
}
