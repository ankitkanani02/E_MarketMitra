import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDataModel {
  String lati;
  String longi;
  String pdetails;
  String pname;
  String pprice;
  String shopname;
  ProductDataModel({
    required this.lati,
    required this.longi,
    required this.pdetails,
    required this.pname,
    required this.pprice,
    required this.shopname,
  });

  factory ProductDataModel.fromFirestore(
      {required DocumentSnapshot<Map<String, dynamic>> doc}) {
    return ProductDataModel(
      lati: doc.data()!["lati"],
      longi: doc.data()!["longi"],
      pdetails: doc.data()!["pdetails"],
      pname: doc.data()!["pname"],
      pprice: doc.data()!["pprice"],
      shopname: doc.data()!["shopName"],
    );
  }
}
