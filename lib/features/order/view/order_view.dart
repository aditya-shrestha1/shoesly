import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/features/order/model/order_model.dart';
import 'package:shoesly/providers.dart';
import 'package:shoesly/styles/app_colors.dart';

import '../../../styles/app_styles.dart';
import '../../../widgets/app_button.dart';
import '../../discover/view/discover_view.dart';

class OrderView extends ConsumerWidget {
  const OrderView({super.key, required this.subTotal});

  final double subTotal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider);
    final orderList = ref.watch(orderDataProvider);
    final grandTotal = ref.watch(cartTotalProvider);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.appWhiteAlt,
      appBar: AppBar(
        title: const Text(
          'Order Summary',
          style: AppStyles.subTitleStyleAlt,
        ),
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.appWhiteAlt,
        leading: InkWell(
          child: const Icon(Icons.keyboard_backspace),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _PaymentInformation(),
                _OrderDetail(orderList: orderList),
                _TotalSummary(
                  height: height,
                  subTotal: subTotal,
                  grandTotal: grandTotal,
                ),
              ],
            ),
          )),
          Positioned(
            bottom: 0,
            child: Container(
              height: height / 8,
              width: width,
              color: AppColors.appWhite,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Grand Total'),
                        Text(
                          grandTotal.toDouble().toStringAsFixed(2),
                        ),
                      ],
                    ),
                    PrimaryAppButton(
                        title: 'PAYMENT',
                        onTap: () async {
                          await order.placeOrder().whenComplete(
                                () => showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: height / 2,
                                      width: width,
                                      decoration: BoxDecoration(
                                        color: AppColors.appWhite,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Stack(
                                            children: [
                                              CircleAvatar(
                                                radius: 42,
                                                backgroundColor:
                                                    AppColors.primaryColor,
                                                child: CircleAvatar(
                                                  radius: 40,
                                                  backgroundColor:
                                                      AppColors.appWhite,
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.check,
                                                    color: AppColors
                                                        .secondaryColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: Text(
                                              'Order placed',
                                              style: AppStyles.titleStyle,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 32.0,
                                              right: 32.0,
                                              top: 48.0,
                                            ),
                                            child: SecondaryAppButton(
                                                title: 'BACK HOME',
                                                onTap: () =>
                                                    Navigator.pushReplacement(
                                                        context,
                                                        CupertinoPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                const DiscoverView()))),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Information',
            style: AppStyles.infoStyle,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: ListTile(
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Method',
                  style: AppStyles.lightStyle,
                ),
                Text(
                  'Credit Card',
                  style: AppStyles.extraLightStyle,
                )
              ],
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.secondaryColor,
              size: 16.0,
            ),
          ),
        ),
        Divider(
          thickness: 2.0,
          color: AppColors.ternaryColor,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: ListTile(
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location',
                  style: AppStyles.lightStyle,
                ),
                Text(
                  'Semarang, Indonesia',
                  style: AppStyles.extraLightStyle,
                )
              ],
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.secondaryColor,
              size: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}

class _OrderDetail extends StatelessWidget {
  final List<OrderModel> orderList;

  const _OrderDetail({required this.orderList});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Order Detail',
            style: AppStyles.infoStyle,
          ),
        ),
        ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderList[index].productName,
                    style: AppStyles.regularStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        orderList[index].brandName,
                        style: AppStyles.extraLightStyle,
                      ),
                      Text(
                        '\$${orderList[index].price.toStringAsFixed(
                              2,
                            )}',
                        style: AppStyles.lightStyle,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: orderList.length,
        ),
      ],
    );
  }
}

class _TotalSummary extends StatelessWidget {
  final double height;
  final double subTotal;
  final double grandTotal;

  const _TotalSummary(
      {
      required this.height,
      required this.subTotal,
      required this.grandTotal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: height / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sub Total',
                  style: AppStyles.extraLightStyle,
                ),
                Text(subTotal.toStringAsFixed(2)),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping',
                  style: AppStyles.extraLightStyle,
                ),
                Text('\$20'),
              ],
            ),
            const Divider(
              thickness: 2.0,
              color: AppColors.ternaryColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Order',
                  style: AppStyles.extraLightStyle,
                ),
                Text(
                  grandTotal.toStringAsFixed(2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
