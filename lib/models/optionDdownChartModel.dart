class OptionDdownChartModel {
  String value;
  String name;

  OptionDdownChartModel({this.value, this.name});
  
  Map<String, dynamic> toMap() => {
        'value': value,
        'name': name,
      };
}
