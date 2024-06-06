import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers.dart';
import '../../../widgets/app_progress_indicator.dart';
import '../../../widgets/product_grid_item.dart';

class DiscoverAllGridView extends ConsumerWidget {
  const DiscoverAllGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brands = ref.watch(allProductProvider);
    final height = MediaQuery.of(context).size.height;

    return brands.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: height,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: data.length,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data[index].discoverData.length,
                    itemBuilder: (BuildContext context, int innerIndex) {
                      final brandData = data[index].discoverData[innerIndex];

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
                  );
                },
              ),
            ),
          );
        },
        error: (e, s) {
          return Text(e.toString());
        },
        loading: () => const AppCircularProgressIndicator());
  }
}
