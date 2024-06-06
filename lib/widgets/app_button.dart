import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/features/filter/view/filter_view.dart';
import 'package:shoesly/providers.dart';
import 'package:shoesly/styles/app_colors.dart';
import 'package:shoesly/styles/app_styles.dart';

class AppFilterButton extends ConsumerWidget {
  const AppFilterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final filter = ref.watch(filterProvider);

    return SizedBox(
      width: width / 3,
      height: height / 16,
      child: FloatingActionButton(
        onPressed: () {
          filter.getColors();
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (BuildContext context) => const FilterView()));
        },
        backgroundColor: AppColors.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              60.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/setting-4.png',
                scale: 1,
              ),
              const Text(
                'FILTER',
                style: AppStyles.lightStyleAlt,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrimaryAppButton extends StatelessWidget {
  final String title;
  final void Function() onTap;

  const PrimaryAppButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              32.0,
            ),
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          title,
          style: AppStyles.lightStyleAlt,
        ),
      ),
    );
  }
}

class FilterResetButton extends StatelessWidget {
  final String title;
  final String filterCount;
  final void Function() onTap;

  const FilterResetButton(
      {super.key,
      required this.title,
      required this.filterCount,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              32.0,
            ),
          ),
        ),
        side: const BorderSide(
          color: AppColors.secondaryColor,
        ),
        elevation: 0,
        backgroundColor: AppColors.appWhite,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          '$title ($filterCount)',
          style: AppStyles.lightStyle,
        ),
      ),
    );
  }
}

class SecondaryAppButton extends StatelessWidget {
  final String title;
  final void Function() onTap;

  const SecondaryAppButton(
      {super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              32.0,
            ),
          ),
        ),
        side: const BorderSide(
          color: AppColors.secondaryColor,
        ),
        elevation: 0,
        backgroundColor: AppColors.appWhite,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          title,
          style: AppStyles.lightStyle,
        ),
      ),
    );
  }
}
