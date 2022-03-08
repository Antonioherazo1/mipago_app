import 'package:flutter/material.dart';
import 'package:mi_pago/models/itemModel.dart';


class ItemCreator extends StatefulWidget {
  final ItemModel item;
  final Function textFieldCallback;
  final String initValue;

  ItemCreator({this.item, this.textFieldCallback, this.initValue});

  @override
  _ItemCreatorState createState() => _ItemCreatorState();
}

class _ItemCreatorState extends State<ItemCreator> {
  var txtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    txtController.text = this.widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          //--- Primer recuadro Amarillo con Nombre del ITEM 
          Container(
            height: 50.0,
            width: 300.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.yellow[50], Colors.yellow[200]]),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              border: Border.all(
                color: Colors.yellow[800],
                width: 2.0,
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: Text(
                    '${widget.item.name}'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                Center(
                  child: Text(
                    widget.item.itemType == 1 // si es un ingreso
                      ? widget.item.fixIncome == true
                        ? 'Cantidad no Variable'
                        : 'Cantidad Variable' // escriba esto
                      : widget.item.itemSubtypeInt == 1 // si no es un ingreso y es subtype 1
                        ? 'Cantidad no variable' // escriba esto
                        : widget.item.itemSubtypeInt == 2 // o si es un subtype 2
                          ? 'Fracción Ingresos del Ciclo' // escriba esto
                          : 'Fracción de Ingresos Mensuales Exedidos' // y si es un Subtype 3 escriba esto otro                            
                    )
                )
              ],
            ),
          ),
          // Segundo Recuadro Amarillo con los Datos y valores del ITEM
          Container(
            height: 70.0,
            width: 380.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.yellow[200], Colors.yellow[600]]),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Colors.yellow[800],
                width: 2.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                widget.item.itemType == 1 // Si es un Ingreso 
                  ? widget.item.fixIncome == true // Y si es el Ingreso Fijo 
                    ? Text( '${widget.item.values}',style: TextStyle(fontSize: 30.0)) // Dibuje un Text 
                    :TextFieldItem(txtController: txtController, widget: widget) //si es un Item de ingreso y el ingreso fijo ya existe dibuje un TextField                                        
                  : Text(''),// En cambio si es un Egreso no dibuje nada 
                Text('${widget.item.middleItemDescrip}',style: TextStyle(fontSize: 15.0)),
                Text("=", style: TextStyle(fontSize: 50.0)),
                Text('${widget.item.total}', style: TextStyle(fontSize: 40.0))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TextFieldItem extends StatelessWidget {
  const TextFieldItem({
    Key key,
    @required this.txtController,
    @required this.widget,
  }) : super(key: key);

  final TextEditingController txtController;
  final ItemCreator widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.0,
      height: 50.0,
      child: TextField(
        controller: txtController,
        style: TextStyle(fontSize: 30.0),
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20)),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: widget.textFieldCallback,
      ),
    );
  }
}
