import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mi_pago/models/itemData.dart';
import 'package:provider/provider.dart';
import 'package:mi_pago/widgets/droppDownSubTypeItem.dart';
import 'package:mi_pago/models/itemModel.dart';

// ignore: must_be_immutable
class AddItemScreen extends StatefulWidget {
  String tipo;
  int itemType;
  int value = 0;
  double factor = 1.0;
  int subTypeItemInt = 1;
  List<String> subTypeItemList = [
    'Cantidad Fija',
    'Fracción Ingresos\ndel ciclo',
    'Fracción Ingresos\nmensuales Exedidos'
  ];

  AddItemScreen({this.tipo});

  @override
  _AddIncomeScreenState createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddItemScreen> {
  String newNameItem = 'Default';
  String middleItemDescrip = '';

  Function updateScreen(){
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(40.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //-------Titulo Nuevo Item a agregar ------------
            Text(
              'AÑADIR NUEVO ${widget.tipo}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            //--------------TextField Ingresar Nombre ------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, right: 30.0),
                  child: Text(
                    'NOMBRE',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                    width: 200.0,
                    height: 50.0,
                    child: TextField(
                      style: TextStyle(fontSize: 20.0),
                      // autofocus: true,
                      textAlign: TextAlign.center,
                      onChanged: (newName) {
                        newNameItem = newName;
                      },
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: widget.tipo == 'EGRESO'
                  ? Column(
                      children: [
                        DroppDownSubTypeItem(), //---DropDown Elegir Suptipo de Item
                        //Si es elegida "Catidad Fija" no se muestra el TextField 'FACTOR'
                        Provider.of<ItemData>(context).subTypeItem ==
                                widget.subTypeItemList[
                                    0] // si el ITEM es de Cantidad Fija
                            ? TFieldNum(
                                title: 'VALOR',
                                widget: widget,
                                destinoValue:
                                    'value') // Entoces Dibuje Este TextField de VALOR
                            : Provider.of<ItemData>(context).subTypeItem ==
                                    widget.subTypeItemList[
                                        1] // Si el ITEM es de Fracción por Ingresos de Ciclo
                                ? TFieldNum(
                                    title: 'FACTOR',
                                    widget: widget,
                                    destinoValue:
                                        'factor') // Entonces Dibuje este otro TextField de FACTOR
                                : Column(
                                    children: [
                                      TFieldNum(
                                          title: 'FACTOR',
                                          widget: widget,
                                          destinoValue: 'factor'),
                                      TFieldNum(title: 'VALOR\nEXEDIDO', widget: widget, destinoValue: 'value')
                                    ],
                                  ) // Y si es de Fraccion de Ingresos exedidos dibuje estos dos TextField de VALOR y FACTOR
                      ],
                    )
                  : TFieldNum(
                      title: 'FACTOR', widget: widget, destinoValue: 'factor'),
            ),
            //-------- FlatButton Añadir --------
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.lightBlueAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                child: Text('Añadir',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  ItemData providerData = Provider.of<ItemData>(context, listen: false);
                  // Se convierte el tipo de Item de String a su equivalente en int
                  widget.itemType = widget.tipo == 'INGRESO' ? 1 : -1;
                  // Se traduce la opción seleccionada de opción tipo String a su valor equivalente en Entero
                  widget.subTypeItemInt = parseIntSubTypeItem(
                      widget.subTypeItemList, providerData.subTypeItem);
                  // se procede a crear el String que describe el factor del item llamando la funcion updateDescripEgress
                  middleItemDescrip = providerData.updateDescripEgress(
                      widget.itemType,
                      widget.factor,
                      widget.subTypeItemInt,
                      widget.value);
                  //Se procede a añadir el nuevo item con los datos listos, dependiendo del tipo de item Income o Egress
                  ItemModel newItem = ItemModel(
                      itemType: widget.itemType,
                      itemSubtypeInt: widget.subTypeItemInt,
                      name: newNameItem,
                      factor: widget.factor,
                      middleItemDescrip: middleItemDescrip,
                      values: widget.value,
                      fixIncome: false,
                      total: widget.tipo ==
                              'EGRESO' // si el item es de tipo Egreso
                          ? widget.subTypeItemInt ==
                                  1 // y tambien es de tipo cantidad fija
                              ? widget
                                  .value // entonces asigne el valor de 'value' al 'total'
                              : widget.subTypeItemInt ==
                                      2 // En cambio si es un Egreso y de Fraccion por ingreso del ciclo
                                  ? (widget.factor * providerData.sumIncome)
                                      .toInt() // asigne a 'total' el valor de la suma de los ingresos por el factor ingresado
                                  : widget.subTypeItemInt ==
                                          3 // Y si al final es un Egreso por Fracción de Ingresos Exedido de cierta cantidad
                                      ? 0
                                      : 0 // TO_DO
                          : 0 // si al final no es un Egreso sinó un Ingreso asigne el valor de 0 a 'total'
                      );

                  widget.tipo == 'EGRESO'
                      ? providerData.addEgressItem(newItem)
                      : providerData.addIncomeItem(newItem);
                  providerData.updateTotal();
                  providerData.saveItemList_SF();//Actualizar total pago
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TFieldNum extends StatelessWidget {
  TFieldNum({this.title, this.widget, this.destinoValue});
  String destinoValue;
  String title;
  AddItemScreen widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0, right: 30.0),
          child: Text(
            this.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 200.0,
          height: 50.0,
          child: TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 20.0),
              // autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newValue) => destinoValue == 'value'
                  ? // escriba el valor en "value"
                  widget.value = int.parse(newValue)
                  : // escriba el valor en "factor"
                  widget.factor = double.parse(newValue)),
        ),
      ],
    );
  }
}

int parseIntSubTypeItem(List<String> subTypeItemList, String subTypeItemStr) {
  int subTypeItem = 1;
  subTypeItemStr == subTypeItemList[0] //cantidad Fija
      ? subTypeItem = 1
      : subTypeItemStr == subTypeItemList[1] // Fracción Ingresos del ciclo
          ? subTypeItem = 2
          : subTypeItem = 3; //Fracción Ingresos mensuales Exedidos
  return subTypeItem;
}
