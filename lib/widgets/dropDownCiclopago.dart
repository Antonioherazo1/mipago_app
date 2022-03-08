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
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ' Periodo de Pago',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
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
              ItemData provider = Provider.of<ItemData>(context, listen: false);
              String descripFactor = 'Horas\n$newValue${'es'}';
              provider.frecPago = newValue;
              setState(() {
                newValue == 'Semanal'
                    ? provider.horasPorCiclo = 56
                    : newValue == 'Quincenal'
                        ? provider.horasPorCiclo = 112
                        : provider.horasPorCiclo = 224;
                //---------
                valueChoosen = newValue;
                if (provider.ingresoFijoExist == false) {
                  final fixIncome = ItemModel(
                      itemType: 1, //Ingreso
                      name: 'Ingreso Fijo',
                      values: provider.horasPorCiclo,
                      factor: 1.0,
                      middleItemDescrip: descripFactor,
                      itemSubtypeInt: 1, // Cantidad Fija
                      fixIncome: true);
                  provider.indexIngFijo = provider.incomeList.length;
                  provider.ingresoFijoExist = true;
                  provider.incomeList.add(fixIncome);
                } else {
                  int index = provider.indexIngFijo;
                  provider.incomeList[index].values = provider.horasPorCiclo;
                  provider.incomeList[index].middleItemDescrip = descripFactor;
                  provider.updateItem();
                }
                // Incvocamos la funcion upDateItem de Provider para actualizar cambio de cicloPago
                provider.updateItem();
                provider.updateTotal();
              });
            },
            //---------------------
          ),
        ],
      ),
    );
  }
}
