import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Loc {
  String title;
  double price;
  String rules = "Not Provided";
  String id = UniqueKey().toString();
  String picUrl;
  String contactInfo = "Not Provided";
  String description = "Not Provided";

  Loc(this.title, this.price, this.rules, this.picUrl, this.contactInfo,
      this.description);

  Map<String, dynamic> toJson() => {
        'title': title,
        'price': price,
        'rules': rules,
        'id': id,
        'picUrl': picUrl,
        'contact': contactInfo,
        'description': description,
      };

  Loc.fromSnapshot(DocumentSnapshot snapshot)
      : title = snapshot['title'],
        price = snapshot['price'],
        rules = snapshot['rules'],
        id = snapshot['id'],
        picUrl = snapshot['picUrl'],
        contactInfo = snapshot['contact'],
        description = snapshot['description'];
}
