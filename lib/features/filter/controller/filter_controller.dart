import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers.dart';

class FilterController extends StateNotifier {
  FilterController(this.ref) : super(ref);

  final StateProviderRef ref;

  void updateMinPrice(int value) {
    ref.read(minPriceValue.notifier).update((state) => value);
  }

  void updateMaxPrice(int value) {
    ref.read(maxPriceValue.notifier).update((state) => value);
  }

  void updateSelectedPrice(int index) {
    ref.read(priceSortIndexProvider.notifier).update((state) => index);
  }

  void updateSelectedGender(int index) {
    ref.read(genderSortIndexProvider.notifier).update((state) => index);
  }

  void updateSelectedColor(int index) {
    ref.read(colorSortIndexProvider.notifier).update((state) => index);
  }

  void updateSelectedSize(int index) {
    ref.read(sizeSortIndexProvider.notifier).update((state) => index);
  }

  void getColors() {
    final colorValues = ref.read(colorOptionsHex);
    final colors = ref.read(colorOptions);
    final List<Color> tempColors = List.from(colors);

    for (var color in colorValues) {
      tempColors.add(Color(int.parse(color)));
    }

    ref.read(colorOptions.notifier).update((state) => tempColors);
  }
}
