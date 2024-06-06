import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/features/cart/controller/cart_controller.dart';
import 'package:shoesly/features/cart/model/cart_model.dart';
import 'package:shoesly/features/discover/controller/discover_controller.dart';
import 'package:shoesly/features/discover/controller/product_controller.dart';
import 'package:shoesly/features/filter/controller/filter_controller.dart';
import 'package:shoesly/features/order/controller/order_controller.dart';
import 'package:shoesly/features/order/model/order_model.dart';
import 'package:shoesly/features/order/model/payment_model.dart';

import 'features/discover/model/discover_model.dart';

//providers for getting brand & product data

final brandProvider =
    StateProvider<DiscoverController>((ref) => DiscoverController(ref));

final productProvider =
    StateProvider<ProductController>((ref) => ProductController(ref));

final brandDataProvider =
    FutureProvider.autoDispose((ref) => ref.read(brandProvider).getBrands());

final brandProductProvider = FutureProvider.family
    .autoDispose<Future<List<DiscoverModel>>, String>((ref, brand) {
  return ref.watch(brandProvider).getProducts(brand);
});

final itemCountProvider = StateProvider<int>((ref) => 1);

final currentBrand = StateProvider<List<DiscoverModel>>((ref) => []);

final currentSelectedBrand = StateProvider<String>((ref) => 'All');

final currentBrandProduct = StateProvider<List<DiscoverData>>((ref) => []);

final allProductProvider = FutureProvider.autoDispose(
    (ref) => ref.read(brandProvider).getAllProducts());

final allSelectedProvider = StateProvider<bool>((ref) => true);

final filterProvider =
    StateProvider<FilterController>((ref) => FilterController(ref));

final filterCountProvider = StateProvider<int>((ref) => 0);

//providers for handling cart & order functionality

final cartProvider =
    StateProvider<CartController>((ref) => CartController(ref));

final cartDataProvider = StateProvider<List<CartModel>>((ref) => []);

final cartCountProvider = StateProvider<int>((ref) => 0);

final productQuantityProvider = StateProvider<int>((ref) => 1);

final cartQuantityProvider = StateProvider<List<int>>((ref) => []);

final totalPriceProvider = StateProvider<double>((ref) => 0.0);

final cartTotalProvider = StateProvider<double>((ref) => 0.0);

final orderProvider = StateProvider<OrderController>((ref) => OrderController(ref));

final orderDataProvider = StateProvider<List<OrderModel>>((ref) => []);

final paymentInformationProvider = StateProvider(
  (ref) => PaymentInformation(
      paymentMethod: 'Credit Card', location: 'Semarang, Indonesia'),
);

//providers for RangeSlider & ChoiceChip
final maxPriceValue = StateProvider<int>((ref) => 1750);

final minPriceValue = StateProvider<int>((ref) => 0);

final priceSortIndexProvider = StateProvider<int>((ref) => 0);

final genderSortIndexProvider = StateProvider<int>((ref) => 0);

final colorSortIndexProvider = StateProvider<int>((ref) => 0);

final sizeSortIndexProvider = StateProvider<int>((ref) => 2);

final priceSortingOptions = StateProvider<List<String>>(
    (ref) => ['Most recent', 'Lowest price', 'Highest price']);

final genderSortingOptions =
    StateProvider<List<String>>((ref) => ['Man', 'Woman', 'Unisex']);

final colorSortingOptions =
    StateProvider<List<String>>((ref) => ['Black', 'White', 'Red', 'Blue']);

final colorOptionsHex = StateProvider<List<String>>(
    (ref) => ['0xFF000000', '0xFFFFFFFF', '0xFFFF0000', '0xFF0000FF']);

final colorOptions = StateProvider<List<Color>>((ref) => []);

final sizeSortingOptions =
    StateProvider<List<String>>((ref) => ['39.5', '40', '40.5', '41', '41.5']);
