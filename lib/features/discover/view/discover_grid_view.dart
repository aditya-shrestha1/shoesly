import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers.dart';
import '../../../widgets/product_grid_item.dart';

class DiscoverGridView extends ConsumerWidget {
  const DiscoverGridView({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brand = ref.watch(currentBrand);

    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: height,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (BuildContext context, int index) {
            final brandData = brand[index];
            return ProductGridItem(
              productTitle: brandData.name,
              review: 2,
              reviewCount: brandData.reviewData.length,
              price: brandData.price,
              productImage: brandData.imageUrl,
              brandLogo: brandData.brandLogoUrl,
              brandName: brandData.brandName,
              description: brandData.description,
              reviewData: brandData.reviewData,
            );
          },
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: brand.length,
        ),
      ),
    );
  }
}
