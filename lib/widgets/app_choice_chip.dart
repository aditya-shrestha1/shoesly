import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/styles/app_styles.dart';

import '../providers.dart';
import '../styles/app_colors.dart';

class PriceChoiceChip extends ConsumerWidget {
  const PriceChoiceChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(filterProvider);
    final options = ref.watch(priceSortingOptions);
    final selected = ref.watch(priceSortIndexProvider);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: height / 8,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ChoiceChip(
              label: Text(
                options[index],
                style: selected == index
                    ? AppStyles.regularStyleAlt
                    : AppStyles.regularStyle,
              ),
              selected: selected == index,
              onSelected: (bool selected) {
                sort.updateSelectedPrice(index);
              },
              showCheckmark: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
              side: const BorderSide(
                color: AppColors.secondaryColor,
              ),
              selectedColor: AppColors.primaryColor,
              backgroundColor: AppColors.appWhiteAlt,
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
      ),
    );
  }
}

class GenderChoiceChip extends ConsumerWidget {
  const GenderChoiceChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(filterProvider);
    final options = ref.watch(genderSortingOptions);
    final selected = ref.watch(genderSortIndexProvider);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: height / 8,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ChoiceChip(
              label: Text(
                options[index],
                style: selected == index
                    ? AppStyles.regularStyleAlt
                    : AppStyles.regularStyle,
              ),
              selected: selected == index,
              onSelected: (bool selected) {
                sort.updateSelectedGender(index);
              },
              showCheckmark: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
              side: const BorderSide(
                color: AppColors.secondaryColor,
              ),
              selectedColor: AppColors.primaryColor,
              backgroundColor: AppColors.appWhiteAlt,
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
      ),
    );
  }
}

class ColorChoiceChip extends ConsumerWidget {
  const ColorChoiceChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(filterProvider);
    final options = ref.watch(colorSortingOptions);
    final selected = ref.watch(colorSortIndexProvider);
    final colors = ref.watch(colorOptions);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: height / 8,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ChoiceChip(
              avatar: CircleAvatar(
                radius: 8,
                backgroundColor: colors[index],
                foregroundColor: AppColors.primaryColor,
              ),
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                  options[index],
                  style: AppStyles.regularStyle,
                ),
              ),
              selected: selected == index,
              onSelected: (bool selected) {
                sort.updateSelectedColor(index);
              },
              showCheckmark: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
              side: BorderSide(
                color: selected == index
                    ? AppColors.primaryColor
                    : AppColors.secondaryColor,
              ),
              selectedColor: AppColors.appWhite,
              backgroundColor: AppColors.appWhiteAlt,
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
      ),
    );
  }
}

class SizeChoiceChip extends ConsumerWidget {
  const SizeChoiceChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(filterProvider);
    final options = ref.watch(sizeSortingOptions);
    final selected = ref.watch(sizeSortIndexProvider);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: height / 8,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ChoiceChip(
            label: Text(
              options[index],
              style: selected == index
                  ? AppStyles.regularStyleAlt
                  : AppStyles.regularStyle,
            ),
            selected: selected == index,
            onSelected: (bool selected) {
              sort.updateSelectedSize(index);
            },
            showCheckmark: false,
            shape: const CircleBorder(
              side: BorderSide(
                color: AppColors.ternaryColor,
              ),
            ),
            side: const BorderSide(
              color: AppColors.secondaryColor,
            ),
            selectedColor: AppColors.primaryColor,
            backgroundColor: AppColors.appWhiteAlt,
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
      ),
    );
  }
}
