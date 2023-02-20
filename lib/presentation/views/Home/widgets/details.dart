import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_court/presentation/styles/app_colors.dart';
import 'package:food_court/presentation/styles/spacing.dart';
import 'package:food_court/presentation/styles/text_styles.dart';
import 'package:food_court/presentation/views/Home/View%20Model/home_viewModel.dart';

class DetailsTile extends ConsumerStatefulWidget {
  const DetailsTile({super.key});

  @override
  ConsumerState<DetailsTile> createState() => _DetailsTileState();
}

class _DetailsTileState extends ConsumerState<DetailsTile> {
  Timer? timer;
  bool? animate = false;
  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(milliseconds: 650),
      (timer) {
        setState(() {
          animate = !animate!;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    if (timer != null) {
      timer?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = ref.watch(homeModelProvider);
    return provider.isLoading
        ? Expanded(
            flex: 3,
            child: Center(
              child: AnimatedScale(
                scale: animate! ? 2 : 1,
                duration: const Duration(milliseconds: 650),
                curve: Curves.easeIn,
                child: Image.asset(
                  "assets/icons/cloudy_load3.png",
                  height: 150,
                  width: 200,
                ),
              ),
            ),
          )
        : Expanded(
            flex: 3,
            child: Padding(
              padding: AppSpacings.horizontalPadding,
              child: provider.isLoading
                  ? const SizedBox()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(
                            "Min/Max:",
                            style: AppTextStyle.headerFive.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          trailing: Text(
                            "${provider.chosenCityWeatherForcast?.main?.tempMin?.toStringAsFixed(0)}/${provider.chosenCityWeatherForcast?.main?.tempMax?.toStringAsFixed(0)} C",
                            style: AppTextStyle.bodyOne.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Feels Like:",
                            style: AppTextStyle.headerFive.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          trailing: Text(
                            "${provider.chosenCityWeatherForcast?.main?.feelsLike} C",
                            style: AppTextStyle.bodyOne.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Pressure:",
                            style: AppTextStyle.headerFive.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          trailing: Text(
                            "${provider.chosenCityWeatherForcast?.main?.pressure} hPa",
                            style: AppTextStyle.bodyOne.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Humidity:",
                            style: AppTextStyle.headerFive.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          trailing: Text(
                            "${provider.chosenCityWeatherForcast?.main?.humidity} %",
                            style: AppTextStyle.bodyOne.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Visibility:",
                            style: AppTextStyle.headerFive.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          trailing: Text(
                            "${provider.chosenCityWeatherForcast?.visibility} Km",
                            style: AppTextStyle.bodyOne.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Rain Volume (Last 1hr):",
                            style: AppTextStyle.headerFive.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          trailing: Text(
                            provider.chosenCityWeatherForcast?.rain
                                        ?.oneHourVolume ==
                                    null
                                ? "No Rain"
                                : "${provider.chosenCityWeatherForcast?.rain?.oneHourVolume}",
                            style: AppTextStyle.bodyOne.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Wind Speed:",
                            style: AppTextStyle.headerFive.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          trailing: Text(
                            "${provider.chosenCityWeatherForcast?.wind?.speed}",
                            style: AppTextStyle.bodyOne.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          );
  }
}
