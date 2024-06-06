import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/features/cart/view/cart_add_view.dart';
import 'package:shoesly/styles/app_colors.dart';
import 'package:shoesly/widgets/app_button.dart';
import 'package:shoesly/widgets/cart_icon.dart';
import '../../../styles/app_styles.dart';
import '../../../widgets/app_choice_chip.dart';
import '../model/discover_model.dart';

class ProductDetailView extends ConsumerWidget {
  final String productTitle;
  final double review;
  final int reviewCount;
  final double price;
  final String productImage;
  final String brandLogo;
  final String brandName;
  final String description;
  final List<Review> reviews;

  const ProductDetailView({
    super.key,
    required this.productTitle,
    required this.review,
    required this.reviewCount,
    required this.price,
    required this.productImage,
    required this.brandLogo,
    required this.brandName,
    required this.description,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.appWhiteAlt,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.appWhiteAlt,
        scrolledUnderElevation: 0,
        leading: InkWell(
          child: const Icon(Icons.keyboard_backspace),
          onTap: () => Navigator.pop(context),
        ),
        actions: const [
          CartIcon(),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProductImage(productImage: productImage),
                  _ProductDescription(
                      productTitle: productTitle,
                      reviewCount: reviewCount,
                      price: price,
                      description: description,
                      reviews: reviews),
                  _ProductReviews(reviews: reviews, height: height),
                ],
              ),
            ),
          ),
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
                        const Text(
                          'Price',
                          style: AppStyles.bodyStyle,
                        ),
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: AppStyles.subTitleStyleAlt,
                        ),
                      ],
                    ),
                    PrimaryAppButton(
                        title: 'ADD TO CART',
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext modalContext) {
                              return CartAddView(
                                  productTitle: productTitle,
                                  price: price,
                                  productImage: productImage,
                                  brandLogo: brandLogo,
                                  brandName: brandName);
                            },
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

class _ProductImage extends StatelessWidget {
  final String productImage;

  const _ProductImage({required this.productImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: 320,
      decoration: BoxDecoration(
        color: AppColors.ternaryColor,
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ColorFiltered(
          colorFilter: const ColorFilter.mode(
            AppColors.ternaryColor,
            BlendMode.multiply,
          ),
          child: Hero(
            tag: UniqueKey(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                productImage,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductDescription extends StatelessWidget {
  final String productTitle;
  final int reviewCount;
  final double price;
  final String description;
  final List<Review> reviews;

  const _ProductDescription(
      {required this.productTitle,
      required this.reviewCount,
      required this.price,
      required this.description,
      required this.reviews});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productTitle,
                  style: AppStyles.subTitleStyleAlt,
                ),
                Row(
                  children: [
                    Image.asset('assets/images/star.png'),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                        '(${reviewCount.toString()} ${reviewCount > 1 ? 'review' : 'review'})')
                  ],
                ),
                Text(
                  price.toStringAsFixed(2),
                  style: AppStyles.lightStyle,
                ),
              ],
            ),
          ),
        ),
        const Text(
          'Size',
          style: AppStyles.regularStyle,
        ),
        const SizeChoiceChip(),
        const Text(
          'Description',
          style: AppStyles.regularStyle,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            description,
            style: AppStyles.extraLightStyle,
          ),
        ),
      ],
    );
  }
}

class _ProductReviews extends StatelessWidget {
  final List<Review> reviews;
  final double height;

  const _ProductReviews({required this.reviews, required this.height});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reviews (${reviews.length})',
            style: AppStyles.regularStyle,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              height: height / 4,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.network(
                      reviews[index].imageUrl,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              reviews[index].name,
                              style: AppStyles.lightStyle,
                            ),
                            const Text(
                              'Today',
                              style: AppStyles.bodyStyle,
                            ),
                          ],
                        ),
                        Text(
                          reviews[index].reviewMessage,
                          style: AppStyles.thinStyle,
                        ),
                      ],
                    ),
                  );
                },
                itemCount: reviews.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
