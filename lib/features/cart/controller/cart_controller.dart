import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/features/cart/model/cart_model.dart';
import 'package:shoesly/features/order/model/order_model.dart';
import 'package:shoesly/providers.dart';

class CartController extends StateNotifier {
  CartController(this.ref)
      : super(CartModel(
            productName: '',
            brandName: '',
            color: '',
            size: '',
            price: 0.0,
            quantity: 0,
            productImage: ''));

  final StateProviderRef ref;

  void addToCart(String productName, String brandName, String color,
      String size, double price, int quantity, String productImage) {
    final cart = ref.read(cartDataProvider);
    final List<CartModel> tempCart = List.from(cart);

    final cartQuantity = ref.read(cartQuantityProvider);
    final List<int> tempCartQuantity = List.from(cartQuantity);

    final orders = ref.read(orderDataProvider);
    final List<OrderModel> tempOrders = List.from(orders);

    tempCart.add(CartModel(
        productName: productName,
        brandName: brandName,
        color: color,
        size: size,
        price: price,
        quantity: quantity,
        productImage: productImage));

    tempCartQuantity.add(quantity);

    tempOrders.add(
      OrderModel(
          productName: productName,
          brandName: brandName,
          color: color,
          size: size,
          price: price,
          quantity: quantity),
    );

    ref.read(orderDataProvider.notifier).update((state) => tempOrders);

    ref.read(cartDataProvider.notifier).update((state) => tempCart);

    ref.read(cartCountProvider.notifier).update((state) => state + 1);

    double calculateTotalPrice(List<CartModel> cart, List<int> cartQuantity) {
      double total = 0.0;
      for (int i = 0; i < cart.length; i++) {
        total += cart[i].price * tempCartQuantity[i];
      }
      return double.parse(total.toStringAsFixed(2));
    }

    final double totalPrice = calculateTotalPrice(tempCart, cartQuantity);
    ref.read(cartTotalProvider.notifier).update((state) => totalPrice);

    ref.read(cartQuantityProvider.notifier).update((state) => tempCartQuantity);

    ref.read(productQuantityProvider.notifier).update((state) => 1);
  }

  void removeFromCart(int index) {
    final cart = ref.read(cartDataProvider);

    //create a temporary list to avoid directly updating the original list
    final List<CartModel> tempCart = List.from(cart);

    final order = ref.read(orderDataProvider);

    final List<OrderModel> orderList = List.from(order);

    orderList.removeAt(index);

    ref.read(orderDataProvider.notifier).update((state) => orderList);

    tempCart.removeAt(index);

    ref.read(cartDataProvider.notifier).update((state) => tempCart);
    ref.read(cartCountProvider.notifier).update((state) => state - 1);

    //ensure that the cart is not empty
    if (tempCart.isNotEmpty) {
      ref
          .read(cartTotalProvider.notifier)
          .update((state) => state - cart[index].price);
    } else {
      ref.invalidate(cartTotalProvider);
    }
  }

  void increaseProductQuantity() {
    ref.read(productQuantityProvider.notifier).update((state) => state + 1);
  }

  void decreaseProductQuantity() {
    ref.read(productQuantityProvider.notifier).update((state) => state - 1);
  }

  void increaseCartProductQuantity(int index) {
    final originalList = ref.read(cartQuantityProvider);
    final cart = ref.read(cartDataProvider);
    final List<int> tempList = List.from(originalList);
    tempList[index]++;

    if (tempList.length == 1 && tempList[index] == 1) {
      ref.read(cartTotalProvider.notifier).update((state) => cart[index].price);
    } else {
      final int newQuantity = tempList[index];
      final double priceChange =
          cart[index].price * (newQuantity - tempList[index] + 1);
      ref
          .read(cartTotalProvider.notifier)
          .update((state) => state + priceChange);
    }

    ref.read(cartQuantityProvider.notifier).update((state) => tempList);
  }

  void decreaseCartProductQuantity(int index) {
    final originalList = ref.read(cartQuantityProvider);
    final cart = ref.read(cartDataProvider);
    final List<int> tempList = List.from(originalList);

    if (tempList[index] != 0) {
      tempList[index]--;
    }

    final double currentTotal = ref.read(cartTotalProvider);

    //ensure that quantity can't be decreased below 1
    if (tempList.length == 1 && tempList[index] == 0) {
      ref
          .read(cartTotalProvider.notifier)
          .update((state) => currentTotal - cart[index].price);
    } else {
      final double priceChange =
          -1 * cart[index].price * (tempList[index] + 1 - tempList[index]);
      ref
          .read(cartTotalProvider.notifier)
          .update((state) => state + priceChange);
    }

    ref.read(cartQuantityProvider.notifier).update((state) => tempList);
  }
}
