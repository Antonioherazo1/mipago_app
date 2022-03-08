class ChartItem {
  int id;
  int value;
  int consecutive;
  String yearMonth;

  ChartItem({ this.id,  this.value,  this.consecutive,  this.yearMonth});

  Map<String, dynamic> toMap() => {
        'id': id,
        'value': value,
        'consecutive':consecutive,
        'yearMonth':yearMonth,
      };
}
