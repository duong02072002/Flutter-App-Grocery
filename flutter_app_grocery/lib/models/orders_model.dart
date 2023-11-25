import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderModel with ChangeNotifier {
  final String orderId,
      userId,
      productId,
      userName,
      price,
      imageUrl,
      quantity,
      productTitle; //Thêm productTitle vào đây
  final Timestamp orderDate;

  OrderModel(
      {required this.orderId,
      required this.userId,
      required this.productId,
      required this.userName,
      required this.price,
      required this.imageUrl,
      required this.quantity,
      required this.productTitle, //Thêm productTitle vào đây
      required this.orderDate});
}
