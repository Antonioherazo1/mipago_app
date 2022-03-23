// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mi_pago/models/itemData.dart';
import 'package:mi_pago/models/monthDataModel.dart';
import 'package:provider/provider.dart';
import 'package:mi_pago/widgets/graphicChart.dart';
import 'package:mi_pago/models/chartItemModel.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class Estadistica extends StatefulWidget {
  String charValueChoosen = '';
  @override
  _EstadisticaState createState() => _EstadisticaState();
}

class _EstadisticaState extends State<Estadistica> {
  String idMonthChoosen = '0';
  String idCicleChoosen = '0';
  int idMonthChoosenInt = 0;
  int idCicleChoosenInt = 0;

  @override
  Widget build(BuildContext context) {
    List<String> itemChartList = [
      'Total Ingresos',
      'Total Descuentos',
      'Pago Total'
    ];

    ItemData provider = Provider.of<ItemData>(context);
    List<Map<String, dynamic>> cicloDataList;
    MonthDataModel monthData;
    if (provider.monthDataList.length > 0) {
      cicloDataList = provider.monthDataList[idMonthChoosenInt].ciclosDataList;
      monthData = provider.monthDataList[idMonthChoosenInt];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Visualización de Datos'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(height: 30.0, color: Colors.orange[300], thickness: 5.0),
              Text(
                'Pago total Mes Actual: \$ ${provider.sumMonthPagoTotal}',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Divider(height: 30.0, color: Colors.orange[300], thickness: 5.0),
              //-------------------------------
              //-------------------------------
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 450, minHeight: 10.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.ciclosDataList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(
                          '${provider.frecPago.replaceAll("l", "")} ${index + 1}',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Total Devengados:  \$ ${provider.ciclosDataList[index].sumIncome}\nTotal Deducciones:  \$ ${provider.ciclosDataList[index].sumEgress}',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        trailing: Text(
                            ' Pago Total ${provider.frecPago.replaceAll("l", "")}: \n \$ ${provider.ciclosDataList[index].totalPago}',
                            style: TextStyle(fontWeight: FontWeight.w800)));
                  },
                ),
              ),
              Divider(height: 30.0, color: Colors.orange[300], thickness: 5.0),

              //-------------------------------
              //-------------------------------
              provider.monthDataList.length < 1
                  ? Text('')
                  : Column(
                      children: [
                        ListTile(
                          title: Text('Elige el mes',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 20.0)),
                          trailing: DropdownButton(
                            hint: Text('mes'),
                            value: idMonthChoosen,
                            items: provider.monthDataList.map((month) {
                              return DropdownMenuItem(
                                value: '${month.id}',
                                child: Text('${month.yearMonth}: ${month.id}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20.0)),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                idMonthChoosen = newValue;
                                idMonthChoosenInt = int.parse(idMonthChoosen);
                              });
                            },
                          ),
                        ),
                        Divider(
                            height: 30.0,
                            color: Colors.orange[300],
                            thickness: 5.0),
                        Text(
                          'Pago total Mes: \$ ${monthData.totalPago}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: 450, minHeight: 56.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: Provider.of<ItemData>(context)
                                .monthDataList[idMonthChoosenInt]
                                .ciclosDataList
                                .length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                  title: Text(
                                    '${monthData.frecPago.replaceAll("l", "")} ${index + 1}',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'Total Devengados:  \$ ${cicloDataList[index]['sumIncome']}\nTotal Deducciones:  \$ ${cicloDataList[index]['sumEgress']}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                  trailing: Text(
                                      ' Pago Total ${monthData.frecPago.replaceAll("l", "")}: \n \$ ${cicloDataList[index]['totalPago']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800)));
                            },
                          ),
                        ),
                        Divider(
                            height: 30.0,
                            color: Colors.orange[300],
                            thickness: 5.0),
                      ],
                    ),
              SizedBox(height: 20),
              Text(
                'GraphicChart',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _dropdownGraphics(),
              Container(
                height: 250,
                child: GraficChart(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _dropdownGraphics extends StatefulWidget {
  @override
  __dropdownGraphicsState createState() => __dropdownGraphicsState();
}

class __dropdownGraphicsState extends State<_dropdownGraphics> {
  @override
  Widget build(BuildContext context) {
    ItemData provider = Provider.of<ItemData>(context);
    List<String> itemDdownChartList = [
      'Total Ingresos',
      'Total Descuentos',
      'Pago Total'
    ];

    return (Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Elige Varible',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
        ),
        DropdownButton(
          hint: Text('Elige una Opción'),
          value: provider.charValueChoosen,
          items: itemDdownChartList.map(
            (chartItem) {
              return DropdownMenuItem(
                value: chartItem,
                child: Text('$chartItem',
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0)),
              );
            },
          ).toList(),
          onChanged: (newValue) {
            int n = 0;
            setState(
              () {
                provider.charValueChoosen = newValue;

                provider.charItemsList.clear();
                String variableChoosen =
                    provider.charValueChoosen == 'Total Ingresos'
                        ? 'sumIncome'
                        : provider.charValueChoosen == 'Total Descuentos'
                            ? 'sumEgress'
                            : 'totalPago';
                ///////////////
                ChartItem chartItem;
                provider.monthDataList.forEach(
                  (month) => {
                    month.ciclosDataList.forEach(
                      (cicle) => {
                        chartItem = ChartItem(
                            id: int.parse(cicle['id'].toString()),
                            consecutive: n++,
                            value:
                                int.parse(cicle['$variableChoosen'].toString()),
                            yearMonth: month.yearMonth),
                        provider.charItemsList.add(chartItem),
                      },
                    )
                  },
                );
                provider.updateTotal();
              },
            );

            print(' Lista: ${provider.charItemsList}');
            provider.charItemsList.forEach(
              (element) {
                print(element.toMap());
              },
            );
          },
        ),
      ],
    ));
  }
}
