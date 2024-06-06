import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/features/discover/view/discover_view.dart';

import '../../../providers.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_styles.dart';
import '../../../widgets/app_button.dart';
import 'cart_view.dart';

class CartAddView extends ConsumerStatefulWidget {
  final String productTitle;

  final double price;
  final String productImage;
  final String brandLogo;
  final String brandName;

  const CartAddView({
    super.key,
    required this.productTitle,
    required this.price,
    required this.productImage,
    required this.brandLogo,
    required this.brandName,
  });
  @override
  ConsumerState<CartAddView> createState() => _CartAddViewState();
}

class _CartAddViewState extends ConsumerState<CartAddView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final cart = ref.watch(cartProvider);
    final quantity = ref.watch(productQuantityProvider);

    return Container(
      height: height / 2,
      decoration: BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add to cart',
                  style: AppStyles.subTitleStyleAlt,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            const Text('Quantity'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  quantity.toString(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: quantity == 1
                          ? () {}
                          : () => cart.decreaseProductQuantity(),
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: quantity == 1
                            ? AppColors.secondaryColor
                            : AppColors.primaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () => cart.increaseProductQuantity(),
                      icon: const Icon(Icons.add_circle_outline_sharp),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              color: AppColors.primaryColor,
            ),
            Container(
              height: height / 8,
              width: width,
              color: AppColors.appWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Total Price'),
                      Text((widget.price * quantity)
                          .toDouble()
                          .toStringAsFixed(2)),
                    ],
                  ),
                  PrimaryAppButton(
                      title: 'ADD TO CART',
                      onTap: () {
                        Navigator.pop(context);
                        cart.addToCart(
                          widget.productTitle,
                          widget.brandName,
                          'Red',
                          'M',
                          (widget.price.toDouble()),
                          quantity,
                          widget.productImage,
                        );
                        showModalBottomSheet(
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 42,
                                        backgroundColor: AppColors.primaryColor,
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundColor: AppColors.appWhite,
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
                                            color: AppColors.secondaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.0),
                                    child: Text(
                                      'Added to cart',
                                      style: AppStyles.titleStyle,
                                    ),
                                  ),
                                  Text(
                                    '${quantity.toString()} ${quantity == 1 ? 'item' : 'items'} total',
                                    style: AppStyles.extraLightStyle,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 32.0,
                                      right: 32.0,
                                      top: 48.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SecondaryAppButton(
                                            title: 'BACK HOME',
                                            onTap: () => Navigator.pushReplacement(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const DiscoverView()))),
                                        PrimaryAppButton(
                                          title: 'TO CART',
                                          onTap: () =>
                                              Navigator.pushReplacement(
                                                  context,
                                                  CupertinoPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const CartView())),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
