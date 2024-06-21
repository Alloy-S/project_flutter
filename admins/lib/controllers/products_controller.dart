import 'dart:io';

import 'package:admins/const/const.dart';
import 'package:admins/controllers/home_controller.dart';
import 'package:admins/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProductsController extends GetxController {
  var isloading = false.obs;

  // textfield
  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();
  var pweightController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  List<Category> category = [];
  List<dynamic> pImagesLink = [];
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);

  var categoryValue = ''.obs;
  var subcategoryValue = ''.obs;
  var selectedColorIndex = 0.obs;

  resetController() {
    pnameController = TextEditingController();
    pdescController = TextEditingController();
    ppriceController = TextEditingController();
    pquantityController = TextEditingController();
    pweightController = TextEditingController();

    categoryList = <String>[].obs;
    subcategoryList = <String>[].obs;
    category = [];
    pImagesLink = [];
    pImagesList = RxList<dynamic>.generate(3, (index) => null);

    categoryValue = ''.obs;
    subcategoryValue = ''.obs;
    selectedColorIndex = 0.obs;
  }

  Future<List<Category>> getCategories() async {
    category.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
    return category;
    // populateSubCategory(cat);
  }

  populateCategoryList() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  populateSubCategory(cat) {
    subcategoryList.clear();

    var data = category.where((element) => element.name == cat).toList();

    for (var item in data.first.subcategory) {
      subcategoryList.add(item);
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);

      if (img == null) {
        return;
      } else {
        pImagesList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImage() async {
    pImagesLink.clear();
    for (var item in pImagesList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination = 'images/verndors/${currentUser!.uid}/$filename';

        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pImagesLink.add(n);
      }
    }
  }

  uploadProduct(context) async {
    var store = firestore.collection(productsCollection).doc();
    await store.set({
      'is_featured': false,
      'p_category': categoryValue.value,
      'p_subcategory': subcategoryValue.value,
      'p_imgs': FieldValue.arrayUnion(pImagesLink),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_desc': pdescController.text,
      'p_name': pnameController.text,
      'p_price': ppriceController.text,
      'p_quantity': pquantityController.text,
      'p_weight': pweightController.text,
      'p_seller': Get.find<HomeController>().username,
      'p_rating': "5.0",
      'vendor_id': currentUser!.uid,
      'featured_id': '',
    });
    isloading(false);

    VxToast.show(context, msg: "Product uploaded");
  }

  addFeatured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'is_featured': true,
      'featured_id': currentUser!.uid,
    }, SetOptions(merge: true));
  }

  removeFeatured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set(
        {'is_featured': false, 'featured_id': ''}, SetOptions(merge: true));
  }

  updateProduct(
      {docId,
      category,
      subcategory,
      desc,
      name,
      price,
      quantity,
      weight,
      context}) async {
    var store = firestore.collection(productsCollection).doc(docId);
    store.set({
      'p_category': category,
      'p_subcategory': subcategory,
      'p_imgs': FieldValue.arrayUnion(pImagesLink),
      'p_desc': desc,
      'p_name': name,
      'p_price': price,
      'p_quantity': quantity,
      'p_weight': weight,
    }, SetOptions(merge: true));
    isloading(false);
    VxToast.show(context, msg: "Product uploaded");
  }

  removeProduct(docId) async {
    await firestore.collection(productsCollection).doc(docId).delete();
  }
}
