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

  /*Map toJson() => {
        'itemType': itemType,
        'itemSubtypeInt': itemSubtypeInt,
        'name': name,
        'factor': factor,
        'middleItemDescrip': middleItemDescrip,
        'value': values,
        'total': total,
        'fixIncome': fixIncome
      };*/


  ItemModel.toItemModel(Map<String, dynamic> map)
      : itemType = map['itemType'],
        itemSubtypeInt= map['itemSubtypeInt'],
        name= map['name'],
        factor= map['factor'],
        middleItemDescrip= map['middleItemDescrip'],
        values= map['values'],
        total= map['total'],
        fixIncome= map['fixIncome'];

  Map<String, dynamic> toMap()=>{
        'itemType': itemType,
        'itemSubtypeInt': itemSubtypeInt,
        'name': name,
        'factor': factor,
        'middleItemDescrip': middleItemDescrip,
        'values': values,
        'total': total,
        'fixIncome': fixIncome
    };
  
}
