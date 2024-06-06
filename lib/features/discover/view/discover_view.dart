import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/providers.dart';
import 'package:shoesly/styles/app_styles.dart';
import 'package:shoesly/widgets/app_button.dart';
import 'package:shoesly/widgets/app_progress_indicator.dart';
import 'package:shoesly/widgets/cart_icon.dart';

import '../../../styles/app_colors.dart';
import 'all_products_view.dart';
import 'discover_grid_view.dart';

class DiscoverView extends ConsumerWidget {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brand = ref.watch(brandDataProvider);
    final all = ref.watch(allSelectedProvider);
    final product = ref.watch(productProvider);

    final currentSelected = ref.watch(currentSelectedBrand);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.appWhiteAlt,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.appWhiteAlt,
        title: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Text(
            'Discover',
            style: AppStyles.titleStyle,
          ),
        ),
        actions: const [
          CartIcon(),
        ],
        automaticallyImplyLeading: false,
      ),
      body: brand.when(
        data: (data) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                final scrollPosition = notification.metrics.pixels;
                final maxScrollPosition = notification.metrics.maxScrollExtent;

                if (scrollPosition >= maxScrollPosition) {
                  debugPrint('bottom');
                  //TODO: add logic to get items when scrolled to bottom
                  //increase itemCount
                }
              }
              return true;
            },
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: false,
                    surfaceTintColor: AppColors.appWhiteAlt,
                    backgroundColor: AppColors.appWhiteAlt,
                    title: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: SizedBox(
                        height: height / 24,
                        width: width,
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (index == 0)
                                  InkWell(
                                      onTap: () async {
                                        await product.selectAllProducts();
                                      },
                                      child: Text(
                                        'All',
                                        style: currentSelected == 'All'
                                            ? AppStyles.subTitleStyleAlt
                                            : AppStyles.subTitleStyle,
                                      )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: InkWell(
                                    child: Text(
                                      data[index],
                                      style: currentSelected == data[index]
                                          ? AppStyles.subTitleStyleAlt
                                          : AppStyles.subTitleStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                    onTap: () async {
                                      await product.selectBrand(data, index);
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: data.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: all
                    ? const DiscoverAllGridView()
                    : const DiscoverGridView(),
              ),
            ),
          );
        },
        error: (e, s) => Text(e.toString()),
        // ignore: prefer_const_constructors
        loading: () => AppCircularProgressIndicator(),
      ),
      floatingActionButton: const AppFilterButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
