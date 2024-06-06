
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/widgets/app_progress_indicator.dart';

import '../../../providers.dart';
import '../model/discover_model.dart';

class ProductController extends StateNotifier {
  ProductController(this.ref)
      : super(DiscoverModel(
          name: '',
          price: 0.0,
          size: '',
          imageUrl: '',
          brandLogoUrl: '',
          brandName: '',
          description: '',
          reviewData: [],
        ));

  final StateProviderRef ref;

  Future<void> selectBrand(List<String> data, int index) async {
    ref.read(brandProductProvider(data[index])).when(
          data: (item) async {
            final products = await item;
            ref.read(currentBrand.notifier).update((state) => products);
            ref
                .read(currentSelectedBrand.notifier)
                .update((state) => data[index]);
          },
          error: (error, stack) {
            return error.toString();
          },
          loading: () => const AppCircularProgressIndicator(),
        );
    ref.read(allSelectedProvider.notifier).update((state) => false);
  }

  Future<void> selectAllProducts() async {
    final allProducts = await ref.read(brandProvider).getAllProducts();
    ref.read(currentBrandProduct.notifier).update((state) => allProducts);
    ref.read(allSelectedProvider.notifier).update((state) => true);
    ref.read(currentSelectedBrand.notifier).update((state) => 'All');
    ref.invalidate(currentBrand);
  }

  Future<void> selectFilteredProducts() async {
    final allProducts = await ref.read(brandProvider).getAllProducts();

    final filtered = [];

    for (var item in allProducts) {
      filtered.add(item);
    }
  }
}
