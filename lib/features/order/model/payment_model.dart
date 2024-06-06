class PaymentInformation {
  final String paymentMethod;
  final String location;

  PaymentInformation({required this.paymentMethod, required this.location});
}

class PaymentDetail {
  final double subTotal;
  final double shippingCost;
  final double totalOrder;

  PaymentDetail(
      {required this.subTotal,
      required this.shippingCost,
      required this.totalOrder});
}
