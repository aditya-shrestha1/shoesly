import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/features/order/view/order_view.dart';
import 'package:shoesly/providers.dart';
import 'package:shoesly/styles/app_colors.dart';
import 'package:shoesly/styles/app_styles.dart';

import '../../../widgets/app_button.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartDataProvider);

    final cartController = ref.watch(cartProvider);

    final cartQuantity = ref.watch(cartQuantityProvider);

    final cartCount = ref.read(cartCountProvider);

    final order = ref.watch(orderProvider);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final totalPrice = ref.watch(cartTotalProvider);

    return Scaffold(
      backgroundColor: AppColors.appWhiteAlt,
      appBar: AppBar(
        title: const Text(
          'Cart',
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
        children: [
          SingleChildScrollView(
            child: Container(
              height: height,
              color: AppColors.appWhiteAlt,
              child: cart.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Dismissible(
                            key: UniqueKey(),
                            onDismissed: (left) =>
                                cartController.removeFromCart(index),
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: AppColors.appHighlightColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Image.asset(
                                'assets/images/trash-icon.png',
                              ),
                            ),
                            child: ListTile(
                              leading: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: AppColors.ternaryColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ColorFiltered(
                                    colorFilter: const ColorFilter.mode(
                                      AppColors
                                          .ternaryColor, // Use BlendMode.clear
                                      BlendMode.multiply,
                                    ),
                                    child: Image.network(
                                      cart[index].productImage,
                                      fit: BoxFit.contain,
                                    )),
                              ),
                              title: Text(cart[index].productName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('${cart[index].brandName} . '),
                                        Text('${cart[index].color} . '),
                                        Text(cart[index].size),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          cart[index].price.toStringAsFixed(2)),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: cartQuantity[index] == 1
                                                ? () {}
                                                : () {
                                                    cartController
                                                        .decreaseCartProductQuantity(
                                                            index);
                                                  },
                                            icon: Icon(
                                              Icons.remove_circle_outline,
                                              color: cartQuantity[index] == 1
                                                  ? AppColors.secondaryColor
                                                  : AppColors.primaryColor,
                                            ),
                                          ),
                                          Text(
                                            cartQuantity[index].toString(),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              cartController
                                                  .increaseCartProductQuantity(
                                                      index);
                                            },
                                            icon: const Icon(
                                                Icons.add_circle_outline_sharp),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cart.length,
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Your cart is currently empty. Please add some items first',
                          style: AppStyles.extraLightStyle,
                        ),
                      ),
                    ),
            ),
          ),
          cartCount > 0
              ? Positioned(
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
                              Text(totalPrice.toDouble().toStringAsFixed(2)),
                            ],
                          ),
                          PrimaryAppButton(
                              title: 'CHECKOUT',
                              onTap: () {
                                order.setGrandTotal();
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (BuildContext context) =>
                                            OrderView(
                                              subTotal: totalPrice,
                                            )));
                              }),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
