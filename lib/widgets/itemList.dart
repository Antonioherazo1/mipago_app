import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mi_pago/models/itemData.dart';
import 'itemCreator.dart';
import 'package:mi_pago/widgets/totalizador.dart';

class ItemList extends StatelessWidget {
  final bool income;

  ItemList({this.income});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemData>(
      builder: (context, itemData, child) {
        return Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Totalizador(total: itemData.totalizador),
              ),
              ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 450, minHeight: 56.0),
                  child: ListView.builder(
                      itemCount: income
                          ? itemData.incomeList.length
                          : itemData.egressList.length,
                      itemBuilder: (context, index) {
                        return income
                            ? ItemCreator(
                                initValue:
                                    '${itemData.incomeList[index].values}',
                                item: itemData.incomeList[index],
                                textFieldCallback: (newValue) {
                                  itemData.incomeList[index].values =
                                      int.parse(newValue);
                                  itemData.updateItem();                                  
                                })
                            : ItemCreator(
                                initValue:
                                    '${itemData.egressList[index].values}',
                                item: itemData.egressList[index],
                                textFieldCallback: () {});
                      })),
            ],
          ),
        );
      },
    );
  }
}
