import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mi_pago/models/itemData.dart';
import 'package:mi_pago/models/itemModel.dart';

class DroppDownCiclopago extends StatefulWidget {
  @override
  _DroppDownCiclopagoState createState() => _DroppDownCiclopagoState();
}


class _DroppDownCiclopagoState extends State<DroppDownCiclopago> {
  final List<String> frecDePagoList = ['Semanal', 'Quincenal', 'Mensual'];

  String valueChoosen;


  @override
  void didChangeDependencies() {
    valueChoosen = Provider.of<ItemData>(context).frecPago;
  }

  loadSharedPreferences(){

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              ' Periodo de Pago',
              textAlign: TextAlign.center,
              style: TextStyle( fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
          ),
          DropdownButton(
            hint: Text('Elige una opcion'),
            //---------------------
            value: valueChoosen,
            //---------------------
            items: frecDePagoList.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Container(
                  width: 100.0,
                  child: Text('$valueItem'),
                ),
              );
            }).toList(),
            //---------------------
            onChanged: (newValue) {
              valueChoosen = Provider.of<ItemData>(context, listen: false).addFixedItem(newValue);
            },
            //---------------------
          ),
        ],
      ),
    );
  }
}
