import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/styles/app_styles.dart';
import 'package:shoesly/widgets/app_progress_indicator.dart';

import '../../../providers.dart';
import '../../../styles/app_colors.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_choice_chip.dart';
import '../../../widgets/app_slider.dart';

class FilterView extends ConsumerWidget {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brand = ref.watch(brandDataProvider);
    final filterCount = ref.watch(filterCountProvider);
    final discover = ref.watch(brandProvider);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.appWhiteAlt,
      appBar: AppBar(
        title: const Text(
          'Filter',
          style: AppStyles.subTitleStyleAlt,
        ),
        centerTitle: true,
        backgroundColor: AppColors.appWhiteAlt,
        leading: InkWell(
          child: const Icon(Icons.keyboard_backspace),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Brands',
                    style: AppStyles.subTitleStyleAlt,
                  ),
                  brand.when(
                    data: (data) {
                      return SizedBox(
                        height: height / 16,
                        width: width,
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(data[index]),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                        ),
                      );
                    },
                    error: (e, s) => Text(e.toString()),
                    loading: () => const AppCircularProgressIndicator(),
                  ),
                  const Text(
                    'Price Range',
                    style: AppStyles.subTitleStyleAlt,
                  ),
                  const PriceSlider(),
                  const Text(
                    'Sort By',
                    style: AppStyles.regularStyle,
                  ),
                  const PriceChoiceChip(),
                  const Text('Gender'),
                  const GenderChoiceChip(),
                  const Text('Color'),
                  const ColorChoiceChip(),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilterResetButton(
                      title: 'RESET',
                      filterCount: filterCount.toString(),
                      onTap: () {},
                    ),
                    PrimaryAppButton(
                        title: 'APPLY',
                        onTap: () {
                          discover.getFilteredProducts();
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
