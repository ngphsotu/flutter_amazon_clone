import 'dart:typed_data';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/simple_product_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '/model/user_details_model.dart';

class CloudFirestoreClass {
  //
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // uploadNameAndAddressToDatabase
  Future uploadNameAndAddressToDatabase(
      {required UserDetailsModel user}) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.getJson());
  }

  // getNameAndAddress
  Future getNameAndAddress() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    UserDetailsModel userModel = UserDetailsModel.getModelFormJson(
      (snap.data() as dynamic),
    );

    return userModel;
  }

  // uploadImageToDatabase
  Future<String> uploadImageToDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child('product').child(uid);
    //
    UploadTask uploadTask = storageRef.putData(image);
    //
    TaskSnapshot task = await uploadTask;

    return task.ref.getDownloadURL();
  }

  // getProductsFromDiscount
  Future<List<Widget>> getProductsFromDiscount(int discount) async {
    List<Widget> children = [];

    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection('products')
        .where('discount', isEqualTo: discount)
        .get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];

      ProductModel model =
          ProductModel.getModelFromJson(json: (docSnap.data() as dynamic));

      children.add(SimpleProductWidget(productModel: model));
    }

    return children;
  }

  // uploadProductToDatabase
  Future<String> uploadProductToDatabase({
    required Uint8List? image,
    required String productName,
    required String rawCost,
    required int discount,
    required String sellerName,
    required String sellerUi,
  }) async {
    productName.trim();

    rawCost.trim();

    String output = "Something went wrong";

    if (image != null && productName != "" && rawCost != "") {
      try {
        String uid = Utils().getUid();

        String url = await uploadImageToDatabase(image: image, uid: uid);

        double cost = double.parse(rawCost);

        cost = cost - (cost * (discount / 100));

        ProductModel product = ProductModel(
          url: url,
          productName: productName,
          cost: cost,
          discount: discount,
          uid: uid,
          sellerName: sellerName,
          sellerUid: sellerName,
          rating: 5,
          noOfRating: 0,
        );

        await firebaseFirestore
            .collection('products')
            .doc(uid)
            .set(product.getJson());

        output = 'success';
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = 'Please make sure all the fields are not empty';
    }

    return output;
  }

  //

  //

  //
}
