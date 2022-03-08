import 'package:flutter/material.dart';
import '../screens/add_ItemScreen.dart';

class AddNewItemButtom extends StatelessWidget {
  final String tipo;

  AddNewItemButtom({this.tipo});

  @override
  Widget build(BuildContext context) {
    return TextButton(      
      style: TextButton.styleFrom(backgroundColor: Colors.lightBlueAccent),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          'NUEVO $tipo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),
      ),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
                    child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddItemScreen(tipo: tipo),
                )));
      },
    );
  }
}
