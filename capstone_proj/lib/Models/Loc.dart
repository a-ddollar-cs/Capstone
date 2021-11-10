import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';



class Loc {
  String title;
  double price;
  String rules;
  String id = UniqueKey().toString();


  Loc(this.title, this.price, this.rules);

  Map<String, dynamic> toJson() => {
    'title': title,
    'price': price,
    'rules': rules,
    'id': id,
  };
}