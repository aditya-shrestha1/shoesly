import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/features/order/model/payment_model.dart';
import 'package:shoesly/providers.dart';

import '../model/order_model.dart';

class OrderController extends StateNotifier {
  OrderController(this.ref)
      : super(OrderModel(
          productName: '',
          brandName: '',
          color: '',
          size: '',
          price: 0.0,
          quantity: 0,
        ));

  final StateProviderRef ref;

  void setGrandTotal() {
    final total = ref.read(cartTotalProvider);

    ref.read(cartTotalProvider.notifier).update((state) => total + 20.0);
  }

  void addOrder(
      OrderModel orderDetail, PaymentDetail paymentDetail, int index) {
    final oldOrder = ref.read(orderDataProvider);
    final List<OrderModel> tempOrderList = List.from(oldOrder);

    tempOrderList.add(
      OrderModel(
          productName: orderDetail.productName,
          brandName: orderDetail.brandName,
          color: orderDetail.color,
          size: orderDetail.size,
          price: orderDetail.price,
          quantity: orderDetail.quantity),
    );

    ref.read(orderDataProvider.notifier).update((state) => tempOrderList);
  }

  Future<void> placeOrder() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    final paymentInformation = ref.read(paymentInformationProvider);

    final orderDetail = ref.read(orderDataProvider);
    final List<Map> orderMap = [];
    final subTotal = ref.read(cartTotalProvider);

    final paymentDetail = PaymentDetail(
        subTotal: subTotal, shippingCost: 20.0, totalOrder: subTotal + 20.0);

    for (var orders in orderDetail) {
      orderMap.add(OrderModel(
              productName: orders.productName,
              brandName: orders.brandName,
              color: orders.color,
              price: orders.price,
              size: orders.size,
              quantity: orders.quantity)
          .toMap(orders));
    }

    try {
      await firebaseFirestore.collection('orders').add({
        'payment_information': {
          'payment_method': paymentInformation.paymentMethod,
          'location': paymentInformation.location,
        },
        'order_detail': FieldValue.arrayUnion(orderMap),
        'Payment Detail': {
          'Sub Total': paymentDetail.subTotal,
          'Shipping': paymentDetail.shippingCost,
          'Total Order': paymentDetail.totalOrder,
        },
        'Grand Total': paymentDetail.totalOrder,
      });
    } catch (e) {
      return;
    }

    ref.invalidate(cartDataProvider);
    ref.invalidate(cartTotalProvider);
    ref.invalidate(cartQuantityProvider);
    ref.invalidate(cartCountProvider);
  }
}
