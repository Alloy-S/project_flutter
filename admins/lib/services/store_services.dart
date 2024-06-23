import 'package:admins/const/const.dart';

class StoreServices {
  static getProfile(uid) {
    return firestore
        .collection(vendorsCollection)
        .where("id", isEqualTo: uid)
        .get();
  }

  static getMessage(uid) {
    print('uid = $uid');

    return firestore
        .collection(chatsCollection)
        .where('toId', isEqualTo: uid)
        .snapshots();
  }

  static getOrders(uid) {
    return firestore
        .collection(ordersCollection)
        .where('vendors', arrayContains: uid)
        .snapshots();
  }

  static getOrdersCount(uid) {

    var snapshot =  firestore
        .collection(ordersCollection)
        .where('vendors', arrayContains: uid)
        .snapshots();
    return snapshot;
  }

  static getProducts(uid) {
    return firestore
        .collection(productsCollection)
        .where('vendor_id', isEqualTo: uid)
        .snapshots();
  }

  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  // static getPopularProducts(uid) {
  //   return firestore.collection(productsCollection).where('vendor_id', isEqualTo: uid).orderBy('p_wishlist'.length);
  // }
}
