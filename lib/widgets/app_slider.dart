import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/providers.dart';
import 'package:shoesly/styles/app_colors.dart';

class PriceSlider extends ConsumerWidget {
  const PriceSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(filterProvider);

    final minValue = ref.watch(minPriceValue.select((value) => value));

    final maxValue = ref.watch(maxPriceValue.select((value) => value));

    return Column(
      children: <Widget>[
        RangeSlider(
          values: RangeValues(minValue.toDouble(), maxValue.toDouble()),
          min: 0,
          max: 1750,
          divisions: 5,
          onChanged: (values) {
            filter.updateMinPrice(values.start.toInt());
            filter.updateMaxPrice(values.end.toInt());
          },
          activeColor: AppColors.primaryColor,
          inactiveColor: AppColors.ternaryColor,
        ),
      ],
    );
  }
}
