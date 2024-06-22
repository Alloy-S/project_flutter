// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/models/category_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var totalPrice = 0.obs;

  var subcat = [];

  var isFav = false.obs;

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart(
      {title, img, sellername, color, qty, tprice, weight, vendorId, context}) async {
    // Get the current user's cart items
    var cartSnapshot = await firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: currentUser!.uid)
        .where('title', isEqualTo: title)
        .where('sellername', isEqualTo: sellername)
        .get();

    if (cartSnapshot.docs.isNotEmpty) {
      // If the item already exists in the cart, update its quantity and total price
      var existingItem = cartSnapshot.docs.first;
      var newQty = existingItem['qty'] + qty;
      var newTprice = existingItem['tprice'] + tprice;
      var newWeight = int.parse(existingItem['weight']) + int.parse(weight);

      await firestore.collection(cartCollection).doc(existingItem.id).update({
        'qty': newQty,
        'tprice': newTprice,
        'weight': newWeight.toString(),
      }).catchError((onError) {
        VxToast.show(context, msg: onError.toString());
      });
      VxToast.show(context, msg: "Added To Cart");
    } else {
      // If the item does not exist in the cart, add a new item
      // addToCart({
      //   title,
      //   img,
      //   sellername,
      //   color,
      //   qty,
      //   tprice,
      //   context,
      //   vendorID,
      // }) async {
      weight = (int.parse(weight) * qty).toString();
      await firestore.collection(cartCollection).doc().set({
        'title': title,
        'img': img,
        'sellername': sellername,
        'qty': qty,
        'vendor_id': vendorId,
        'tprice': tprice,
        'added_by': currentUser!.uid,
        'weight': weight,
      }).catchError((onError) {
        VxToast.show(context, msg: onError.toString());
      });
      // }
      VxToast.show(context, msg: "Added To Cart");
    }
  }

  resetValue() {
    totalPrice.value = 0;
    quantity.value = 0;
  }

  addToWishList(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));

    isFav(true);
    VxToast.show(context, msg: "Added to wishlist");
  }

  removeFromWishList(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));

    isFav(false);
    VxToast.show(context, msg: "Removed from wishlist");
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
