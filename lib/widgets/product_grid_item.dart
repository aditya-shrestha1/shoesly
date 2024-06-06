import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoesly/features/discover/view/product_detail_view.dart';
import 'package:shoesly/styles/app_colors.dart';
import 'package:shoesly/styles/app_styles.dart';

import '../features/discover/model/discover_model.dart';

class ProductGridItem extends StatelessWidget {
  final String productTitle;
  final double review;
  final int reviewCount;
  final double price;
  final String productImage;
  final String brandLogo;
  final String brandName;
  final String description;
  final List<Review> reviewData;

  const ProductGridItem({
    super.key,
    required this.productTitle,
    required this.review,
    required this.reviewCount,
    required this.price,
    required this.productImage,
    required this.brandLogo,
    required this.brandName,
    required this.description,
    required this.reviewData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (BuildContext context) => ProductDetailView(
              productTitle: productTitle,
              review: review,
              reviewCount: reviewCount,
              price: price,
              productImage: productImage,
              brandLogo: brandLogo,
              brandName: brandName,
              description: description,
              reviews: reviewData,
            ),
          )),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                    color: AppColors.ternaryColor,
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                  ),
                  child: ClipRect(
                    child: ColorFiltered( //This caused the grey overlay issue
                      colorFilter: const ColorFilter.mode(
                        AppColors.ternaryColor,
                        BlendMode.multiply,
                      ),
                      child: Hero(
                        tag: UniqueKey(),
                        child: Image.network(
                          productImage,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(top: 16, left: 16, child: Image.network(brandLogo)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productTitle,
                    style: AppStyles.thinStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/images/star.png'),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: Text(
                        '(${reviewCount.toString()} Reviews)',
                        style: AppStyles.bodyStyle,
                      )),
                    ],
                  ),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: AppStyles.lightStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
