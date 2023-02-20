import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import "package:food_court/core/Extensions/extensions.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_court/api/keys/api_keys.dart';
import 'package:food_court/core/Utilities/Validators/validator.dart';
import 'package:food_court/presentation/styles/app_colors.dart';
import 'package:food_court/presentation/styles/spacing.dart';
import 'package:food_court/presentation/styles/text_styles.dart';
import 'package:food_court/presentation/views/Home/View%20Model/home_viewModel.dart';

class MainInfoTile extends ConsumerStatefulWidget {
  const MainInfoTile({super.key});

  @override
  ConsumerState<MainInfoTile> createState() => _MainInfoTileState();
}

class _MainInfoTileState extends ConsumerState<MainInfoTile> {
  @override
  Widget build(BuildContext context) {
    var provider = ref.watch(homeModelProvider);
    return Padding(
      padding: AppSpacings.horizontalPadding,
      child: SizedBox(
        height: 120,
        child: provider.isLoading
            ? !provider.locationServiceEnabled!
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Location Service is Off. Turn it on and try again",
                          style: AppTextStyle.bodyThree.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: GestureDetector(
                            onTap: () async {
                              await provider.initialize();
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    AppColors.primaryGradient3.withOpacity(0.5),
                              ),
                              child: const Icon(
                                Icons.refresh,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: Image.asset(
                      "assets/icons/cloudy_load3.png",
                      height: 60,
                      width: 70,
                    ),
                  )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(
                            seconds: 1,
                          ),
                          opacity: provider.isLoading ? 0 : 1,
                          child: Text(
                            "${provider.chosenCityWeatherForcast?.name!}",
                            style: AppTextStyle.headerFour
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                        SizedBox(
                          height: provider.isLoading ? 20 : 0,
                        ),
                        AnimatedOpacity(
                          duration: const Duration(
                            seconds: 1,
                          ),
                          opacity: provider.isLoading ? 0 : 1,
                          child: Text(
                            "${provider.chosenCity?.country}",
                            style: AppTextStyle.headerThree
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          Validators.dateTimeToString(DateTime.now()),
                          style: AppTextStyle.headerFive.copyWith(
                            color: AppColors.textGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          // textBaseline: TextBaseline.alphabetic,
                          children: [
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: CachedNetworkImage(
                                imageUrl:
                                    "${ApiKeys.weatherIcon}${provider.chosenCityWeatherForcast?.weather?.first.icon}@2x.png",
                                placeholder: (context, url) => const SizedBox(),
                              ),
                            ),
                            Text(
                              "${provider.chosenCityWeatherForcast?.main?.temp?.toStringAsFixed(0)}\u00B0",
                              style: AppTextStyle.headerOne.copyWith(
                                fontSize: provider.isLoading ? 14 : 40,
                                color: AppColors.white,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        AnimatedOpacity(
                          opacity: provider.isLoading ? 0 : 1,
                          duration: const Duration(seconds: 1),
                          child: Text(
                            "${provider.chosenCityWeatherForcast?.weather?.first.description?.capitalize()}",
                            style: AppTextStyle.headerFive.copyWith(
                              color: AppColors.textGray,
                              height: 1,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
