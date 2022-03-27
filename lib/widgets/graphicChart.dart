import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mi_pago/models/itemData.dart';
import 'package:mi_pago/models/chartItemModel.dart';
import 'dart:math';

class GraficChart extends StatefulWidget {
  @override
  _GraficChartState createState() => _GraficChartState();
}

class _GraficChartState extends State<GraficChart> {
  var data;
  var datas;

  @override
  void initState() {
    super.initState();
    var r = Random();
    data = List<double>.generate(30, (i) => r.nextDouble() * 1500);
  }

  _onSelectionChanged(SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    var time;
    final measures = <String, double>{};

    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum;
      selectedDatum.forEach((SeriesDatum datumPair) {
        measures[datumPair.series.displayName] = datumPair.datum;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemData>(
      builder: (context, itemData, child) {
        List<dynamic> list = itemData.charItemsList;
        datas =
            List<double>.generate(list.length, (i) => list[i].value.toDouble());

        itemData.charItemsList.forEach((e) {
          return TickSpec(0, label: '01');
        });

        List<Series<double, num>> series = [
          Series<double, int>(
              id: 'Sales',
              colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
              domainFn: (value, index) => index,
              measureFn: (value, _) => value,
              data: datas,
              strokeWidthPxFn: (_, __) => 4)
        ];

        return LineChart(
          series,
          animate: false,
          selectionModels: [
            SelectionModelConfig(
              type: SelectionModelType.info,
              changedListener: _onSelectionChanged,
            )
          ],
          domainAxis: NumericAxisSpec(
              tickProviderSpec: StaticNumericTickProviderSpec(list.map(
            (item) {
              return TickSpec(item.consecutive,
                  label: '${item.yearMonth}.${item.id}');
            },
          ).toList())),
          primaryMeasureAxis: NumericAxisSpec(
            tickProviderSpec: BasicNumericTickProviderSpec(
              desiredTickCount: 4,
            ),
          ),
        );
      },
    );
  }
}
