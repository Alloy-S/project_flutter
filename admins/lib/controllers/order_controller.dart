import 'package:admins/const/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var order = [];

  var confirmed = false.obs;
  var onDelivery = false.obs;
  var delivered = false.obs;

  getOrders(data) {
    order.clear();
    for (var item in data['orders']) {
      if (item['vendor_id'] == currentUser!.uid) {
        order.add(item);
      }
    }
  }

  changeStatus({title, status, docID}) async {
    var store = firestore.collection(ordersCollection).doc(docID);

    await store.set({
      title: status,
    }, SetOptions(merge: true));
  }
}
