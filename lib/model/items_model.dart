import 'package:flutter/cupertino.dart';

class ListItems {
  final int num;
  final int grandTotal;
  final String formattedGrandTotal;
  final String item;
  final String itemPrice;
  final String formattedPrice;
  final String itemQnty;
  final String prod;
  final String formattedProd;

  ListItems({
    required this.num,
    required this.grandTotal,
    required this.formattedGrandTotal,
    required this.item,
    required this.itemPrice,
    required this.formattedPrice,
    required this.itemQnty,
    required this.prod,
    required this.formattedProd,
  });
  static List<ListItems> allItems = [];
}