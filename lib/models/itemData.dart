import 'package:mi_pago/models/cicloDataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mi_pago/models/itemModel.dart';
import 'package:intl/intl.dart';
import 'package:mi_pago/models/monthDataModel.dart';
import 'dart:convert';
import 'package:mi_pago/models/chartItemModel.dart';

class ItemData extends ChangeNotifier {
  int horasLaboralesDiarias = 8;
  int valorUnitario = 0;
  int totalizador = 0;
  int sumIncome = 0;
  int sumEgress = 0;
  int sumMonthIncomes = 0;
  int sumMonthEgress = 0;
  int sumMonthPagoTotal = 0;
  String frecPago;
  String charValueChoosen;
  int horasPorCiclo;
  bool ingresoFijoExist = false;
  String factorPo = 'Valor hora';
  int indexIngFijo = 0;
  String subTypeItem = '';

  List<ItemModel> incomeList = [];
  List<ItemModel> egressList = [];
  List<CicloDataModel> ciclosDataList = [];
  List<MonthDataModel> monthDataList = [];
  List<ChartItem> charItemsList = [];

  void addIncomeItem(ItemModel newItem) {
    incomeList.add(newItem); // Se añade el nuevo item a Egresos
    notifyListeners(); //se notifican los Consumidores del provider
  }

  void addEgressItem(ItemModel newItem) {
    egressList.add(newItem); // Se añade el nuevo item a Egresos
    notifyListeners(); //se notifican los Consumidores del provider
  }

  void updateItem() {
    //Actualizamos Intem de ingresos
    incomeList.forEach((item) {
      item.total = (item.values * item.factor * valorUnitario).toInt();
    });

    updateTotal();
    //Actualizar todos Item de egresos
    egressList.forEach(
      (egressItem) {
        egressItem.itemSubtypeInt == 2
            ? egressItem.total = (egressItem.factor * sumIncome).toInt()
            : egressItem.itemSubtypeInt == 3
                ? egressItem.total = 9999 // TO_DO
                : egressItem.total = egressItem.values;

        // Actulizamos las decripciones de cada ITEM de Egress
        egressItem.middleItemDescrip = updateDescripEgress(egressItem.itemType,
            egressItem.factor, egressItem.itemSubtypeInt, egressItem.values);
      },
    );
    updateTotal();
  }

  String updateDescripEgress(
      int tipo, double factor, int supTypeItemInt, int value) {
    String factorDescrip = '';
    tipo == 1
        ? factorDescrip =
            '''Por  $factor\nPor Valor\nde la Hora''' // descripcion para ingresos
        : supTypeItemInt == 1
            ? factorDescrip = '$subTypeItem' // Descrip Egresos Fijos
            : supTypeItemInt == 2
                ? factorDescrip =
                    '''$factor por\nlos Ingresos\ndel ciclo: $sumIncome''' // descripcion Egresos Fraccion de Ingresos del ciclo
                : factorDescrip =
                    '''$factor por\nIngresos Mensuales\exedidos en: $value '''; // descripcion Egresos Fraccion de Ingresos Mensuales exedidos
    return factorDescrip;
  }

  void updateValorUnit(int valorUnitario) {
    this.valorUnitario = valorUnitario;
    incomeList.forEach((income) {
      int producto = (valorUnitario * income.values * income.factor).toInt();
      income.total = producto;
      updateTotal();
    });
    egressList.forEach((egress) {
      int producto = (valorUnitario * egress.values * egress.factor).toInt();
      egress.total = producto;
      updateTotal();
    });
  }

  void updateTotal() {
    sumIncome = 0;
    sumEgress = 0;
    sumMonthPagoTotal = 0;
    sumMonthIncomes = 0;
    sumMonthEgress = 0;

    // Calculo sumatoria ingresos del ciclo
    incomeList.forEach((income) {
      sumIncome += income.total;
    });
    // Calculo sumatoria egresos del ciclo
    egressList.forEach((egress) {
      sumEgress += egress.total;
    });
    totalizador = sumIncome - sumEgress;
    //Calculo sumatoria ingresos del mes
    ciclosDataList.forEach((ciclo) {
      sumMonthIncomes += ciclo.sumIncome;
    });
    // cálculo pago total del mes
    ciclosDataList.forEach((ciclo) {
      sumMonthPagoTotal += ciclo.totalPago;
    });

    // cálculo descuentos totales del mes
    ciclosDataList.forEach((ciclo) {
      sumMonthEgress += ciclo.sumEgress;
    });

    notifyListeners();
  }

  void saveCiclo() {
    var now = DateTime.now();
    var yearMonthFormater = DateFormat('yMMMM');
    String yearMonth = yearMonthFormater.format(now);

    List<Map<String, dynamic>> incomeListMap = [];
    List<Map<String, dynamic>> egressListMap = [];
    incomeList.forEach((element) => incomeListMap.add(element.toMap()));
    egressList.forEach((element) => egressListMap.add(element.toMap()));

    CicloDataModel cicleData = CicloDataModel(
        incomeList: incomeListMap,
        egressList: egressListMap,
        dateString: yearMonth,
        totalPago: totalizador,
        sumIncome: sumIncome,
        sumEgress: sumEgress,
        id: ciclosDataList.length);

    //-------------------------

    ciclosDataList.add(cicleData);




    //reiniciar valores de items de cantidad variable a cero
    incomeList.forEach((item) {
      int n;
      item.fixIncome == false ? item.values = 0 : n = 0;
    });
    updateItem();
  }

  void saveMes() {
    var now = DateTime.now();
    var yearMonthFormater = DateFormat('yMMMM');
    String yearMonth = yearMonthFormater.format(now);

    //se crea un objeto de tipo MonthDataModel y lo alimentamos con valores

    List<Map<String, dynamic>> ciclosDataListMap = [];
    ciclosDataList.forEach((element) => ciclosDataListMap.add(element.toMap()));

    final monthData = MonthDataModel(
        ciclosDataList: ciclosDataListMap,
        yearMonth: yearMonth,
        sumIncomesMonth: sumMonthIncomes,
        sumEgressMonth: sumMonthEgress,
        totalPago: sumMonthPagoTotal,
        frecPago: frecPago,
        id: monthDataList.length);
    //Añadimos el nuevo Mes a la lista
    monthDataList.add(monthData);

    updateTotal();

    ciclosDataList.clear();
  }
}
