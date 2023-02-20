import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_court/api/keys/api_keys.dart';
import 'package:food_court/core/Utilities/Helper%20Functions/popups.dart';
import 'package:food_court/presentation/styles/app_colors.dart';
import 'package:food_court/presentation/styles/spacing.dart';
import 'package:food_court/presentation/styles/text_styles.dart';
import 'package:food_court/presentation/views/Home/View%20Model/home_viewModel.dart';

class WatchListTile extends ConsumerStatefulWidget {
  const WatchListTile({super.key});

  @override
  ConsumerState<WatchListTile> createState() => _WatchListTileState();
}

class _WatchListTileState extends ConsumerState<WatchListTile> {
  @override
  Widget build(BuildContext context) {
    var provider = ref.watch(homeModelProvider);
    var size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppSpacings.horizontalPadding,
            child: Text(
              "Watch List",
              style: AppTextStyle.headerFive.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: double.infinity,
            child: CarouselSlider(
              items:
                  provider.listOfFavouriteCities?.mapIndexed((index, element) {
                var item = provider.listOfFavouriteCities?[index];
                return GestureDetector(
                  onTap: () async {
                    await provider.setChosenCity(item!.cityInfo!.city!);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primary.withOpacity(0.6),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 20,
                            spreadRadius: 5,
                            color: AppColors.timeTileColor.withOpacity(0.1))
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              log("Tapped");
                              AppPopUps.showConfirmPopup(context, size.height,
                                  size.width, item!.cityInfo!.city!);
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                  color: AppColors.containerColor,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20))),
                              child: const Icon(
                                Icons.find_replace,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${item?.cityInfo?.city!}\n ",
                                        style: AppTextStyle.headerFour.copyWith(
                                          fontSize: 18,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "${item?.cityInfo?.iso2!}  ",
                                        style: AppTextStyle.bodyFive.copyWith(
                                          color: AppColors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "${ApiKeys.weatherIcon}${item?.weatherForcast?.weather?.first.icon}@2x.png",
                                        placeholder: (context, url) =>
                                            const SizedBox(),
                                      ),
                                    ),
                                    Text(
                                      "${item?.weatherForcast?.main?.temp?.toStringAsFixed(0)}\u00B0",
                                      style: AppTextStyle.headerOne.copyWith(
                                        fontSize: 30,
                                        color: AppColors.white,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                  height: 110,
                  aspectRatio: 2,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  viewportFraction: 0.7,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height),
            ),
          )
        ],
      ),
    );
  }
}
