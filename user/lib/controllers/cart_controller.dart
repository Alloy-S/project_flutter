import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:emart_app/controllers/uid_generator.dart';
import 'package:emart_app/models/rajaongkir_cost_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totalP = 0.obs;
  var totalCourier = 0;

  // Text controllers for shipping data
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalcodeController = TextEditingController();
  var phoneController = TextEditingController();

  // data for province and city

  var strProvinceId = ''.obs;
  var strKotaId = ''.obs;
  var strProvince = ''.obs;
  var strKota = ''.obs;
  var strVendorKotaId = ''.obs;
  var strVendorKota = ''.obs;
  var strVendorProvinceId = ''.obs;
  var strVendorProvince = ''.obs;

  var paymentIndex = 0.obs;

  late dynamic productSnapshot;
  var products = [];
  var vendors = [];
  var weight = [];
  List<Courier> courier = [];

  var placingOrder = false.obs;

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);

    // await getProductDetails();
    List<Map<String, dynamic>> couriersData =
        courier.map((courier) => courier.toMap()).toList();

    await firestore.collection(ordersCollection).doc().set({
      'order_code': UidGenerator.getRandomString(10),
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state_id': strProvinceId.value,
      'order_by_state': strProvince.value,
      'order_by_city_id': strKotaId.value,
      'order_by_city': strKota.value,
      'order_by_phone': phoneController.text,
      'order_by_postalcode': postalcodeController.text,
      'shipping_method': "Home Delivery",
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_product' : totalAmount,
      'total_amount': totalAmount + totalCourier,
      'orders': FieldValue.arrayUnion(products),
      'vendors': FieldValue.arrayUnion(vendors),
      'weight': FieldValue.arrayUnion(weight),
      'courier': couriersData,
    });
    placingOrder(false);
  }

  getProductDetails() async {
    products.clear();
    print('mengumpulkan semua data');
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        // 'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'vendor_id': productSnapshot[i]['vendor_id'],
        'tprice': productSnapshot[i]['tprice'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
      });
      if (!vendors.contains(productSnapshot[i]['vendor_id']) ||
          vendors.isEmpty) {
        vendors.add(productSnapshot[i]['vendor_id']);
        weight.add(int.parse(productSnapshot[i]['weight']));
        await firestore
            .collection(vendorsCollection)
            .where('id', isEqualTo: productSnapshot[i]['vendor_id'])
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            strVendorKotaId.value = value.docs.single['shop_kota_id'];
            strVendorKota.value = value.docs.single['shop_kota'];
            strVendorProvinceId.value = value.docs.single['shop_province_id'];
            strVendorProvince.value = value.docs.single['shop_province'];
          }
        });
        print(strVendorKota);
        // strVendorKotaId.value = n;
      } else {
        var index = vendors.indexWhere(
            (element) => element == productSnapshot[i]['vendor_id']);
        weight[index] = weight[index] + int.parse(productSnapshot[i]['weight']);
      }
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }

  void incrementQuantity(String docId, int currentQty) {
    var item = productSnapshot.firstWhere((element) => element.id == docId);
    var currentPrice = item['tprice'] ~/ item['qty'];
    var currentWeight = int.parse(item['weight']) ~/ item['qty'];
    firestore.collection(cartCollection).doc(docId).update({
      'qty': currentQty + 1,
      'tprice': (currentQty + 1) * currentPrice,
      'weight': ((currentQty + 1) * currentWeight).toString(),
    });
  }

  void decrementQuantity(String docId, int currentQty) {
    if (currentQty > 1) {
      var item = productSnapshot.firstWhere((element) => element.id == docId);
      var currentPrice = item['tprice'] ~/ item['qty'];
      var currentWeight = int.parse(item['weight']) ~/ item['qty'];
      firestore.collection(cartCollection).doc(docId).update({
        'qty': currentQty - 1,
        'tprice': (currentQty - 1) * currentPrice,
        'weight': ((currentQty - 1) * currentWeight).toString(),
      });
    }
  }

  addCourier({
    name,
    service,
    description,
    value,
    etd,
    cityName,
    cityId,
    provinceName,
    provinceId,
  }) {
    totalCourier += int.parse( value.toString());
    courier.add(Courier(
        name: name,
        service: service,
        description: description,
        value: value,
        etd: etd,
        cityName: cityName,
        cityId: cityId,
        provinceName: provinceName,
        provinceId: provinceId));
  }
}
