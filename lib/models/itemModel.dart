class ItemModel {
  int itemType;
  int itemSubtypeInt = 1;
  String name = '';
  double factor = 1.0;
  bool fixIncome = false;
  String middleItemDescrip;
  int values = 0;
  int total = 0;

  ItemModel(
      {this.itemType,
      this.itemSubtypeInt,
      this.name,
      this.factor,
      this.middleItemDescrip,
      this.values,
      this.total,
      this.fixIncome});

  Map toJson() => {
        'itemType': itemType,
        'itemSubtypeInt': itemSubtypeInt,
        'name': name,
        'factor': factor,
        'middleItemDescrip': middleItemDescrip,
        'value': values,
        'total': total,
        'fixIncome': fixIncome
      };

  Map<String, dynamic> toMap()=>{
        'itemType': itemType,
        'itemSubtypeInt': itemSubtypeInt,
        'name': name,
        'factor': factor,
        'middleItemDescrip': middleItemDescrip,
        'value': values,
        'total': total,
        'fixIncome': fixIncome
    };
  
}
