import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/providers.dart';
import 'package:shoesly/styles/app_colors.dart';

import '../features/cart/view/cart_view.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount = ref.watch(cartCountProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: InkWell(
          onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (BuildContext context) => const CartView())),
          child: cartCount == 0
              ? Image.asset('assets/images/bag-2.png')
              : Stack(
                  children: [
                    Image.asset('assets/images/bag-2.png'),
                    Positioned(
                      right: 0,
                      top: 4,
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: AppColors.appHighlightColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    )
                  ],
                )),
    );
  }
}
