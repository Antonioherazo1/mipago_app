

class MonthDataModel {
  List<Map<String, dynamic>> ciclosDataList;
  int id;
  String yearMonth;
  int sumIncomesMonth;
  int sumEgressMonth;
  int totalPago;
  String frecPago = 'ciclo';

  MonthDataModel({
    this.ciclosDataList,
    this.yearMonth,
    this.sumIncomesMonth,
    this.sumEgressMonth,
    this.totalPago,
    this.id,
    this.frecPago,
  });

  Map toJson() => {
        'ciclosDataList': ciclosDataList,
        'yearMonth': yearMonth,
        'sumIncomesMonth': sumIncomesMonth,
        'sumEgressMonth': sumEgressMonth,
        'totalPago': totalPago,
        'frecPago': frecPago,
        'id': id
      };
}
