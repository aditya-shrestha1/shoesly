import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/discover_model.dart';

class DiscoverController extends StateNotifier {
  DiscoverController(this.ref)
      : super(
          DiscoverModel(
            name: '',
            price: 0.0,
            size: '',
            imageUrl: '',
            brandLogoUrl: '',
            brandName: '',
            description: '',
            reviewData: [],
          ),
        );

  final StateProviderRef ref;

  Future<List<String>> getBrands() async {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    final List<String> brandList = [];

    await firebase.collection('brands').get().then((value) {
      for (var element in value.docs) {
        brandList.add(element.id);
      }
    });

    return brandList;
  }

  Future<List<DiscoverModel>> getProducts(String docID) async {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    List<DiscoverModel> products = [];

    try {
      final data = await firebase.collection('brands').doc(docID).get();

      for (var item in data.data()!.entries) {
        for (var obj in item.value) {
          products.add(DiscoverModel.fromJson(obj));
        }
      }
      return products;
    } catch (e) {
      debugPrint('The error is: $e');
      return [];
    }
  }

  Future<List<DiscoverData>> getAllProducts() async {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    List<DiscoverData> products = [];

    try {
      await firebase.collection('brands').get().then((value) {
        for (var docSnapshot in value.docs) {
          products.add(DiscoverData.fromJson(docSnapshot.data()));
        }
      });
      return products;
    } catch (e) {
      debugPrint('The error is: $e');
      return [];
    }
  }

  Future<List<DiscoverData>> getFilteredProducts() async {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    List<DiscoverData> products = [];

    //TODO: Properly configure filtering
    try {
      await firebase
          .collection('brands')
          .where('shoes', arrayContains: 'Nike Air')
          .get()
          .then((value) {
        for (var docSnapshot in value.docs) {
          products.add(DiscoverData.fromJson(docSnapshot.data()));
        }
      });
      return products;
    } catch (e) {
      debugPrint('The error is: $e');
      return [];
    }
  }
}
