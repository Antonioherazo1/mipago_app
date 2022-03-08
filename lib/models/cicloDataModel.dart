class CicloDataModel {
  List<Map<String, dynamic>> incomeList;
  List<Map<String, dynamic>> egressList;
  DateTime date;
  String dateString;
  int totalPago;
  int id;
  int sumIncome;
  int sumEgress;

  CicloDataModel(
      { this.incomeList,
         this.egressList,
         this.date,
         this.totalPago,
         this.dateString,
         this.sumIncome,
         this.sumEgress,
         this.id});

  Map toJson() => {
        'incomeList': incomeList,
        'egressList': egressList,
        'date': date,
        'totalPago': totalPago,
        'dateString': dateString,
        'sumIncome': sumIncome,
        'sumEgress': sumEgress,
        'id': id
      };

  Map<String, dynamic> toMap() => {
        'incomeList': incomeList,
        'egressList': egressList,
        'date': date,
        'totalPago': totalPago,
        'dateString': dateString,
        'sumIncome': sumIncome,
        'sumEgress': sumEgress,
        'id': id
      };
}
