// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_court/presentation/styles/app_colors.dart';
import 'package:food_court/presentation/styles/text_styles.dart';
import 'package:food_court/presentation/views/Home/View%20Model/home_viewModel.dart';
import 'package:go_router/go_router.dart';

class AppPopUps {
  static void showConfirmPopup(BuildContext rootContext, double height,
      double width, String oldCityName) {
    showDialog(
      context: rootContext,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Center(
              child: Consumer(
                builder: (context, ref, child) => Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: height * 0.8,
                  width: width * 0.7,
                  padding: const EdgeInsets.all(20),
                  child: Card(
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColors.white
                        : Theme.of(context).colorScheme.primaryContainer,
                    elevation: 0,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Replace from the list below:",
                            style: AppTextStyle.headerThree,
                          ),
                          SizedBox(
                            // height: height * 0.8,
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: ref
                                  .read(homeModelProvider)
                                  .listOfFifteenCities!
                                  .length,
                              itemBuilder: (context, index) {
                                var item = ref
                                    .read(homeModelProvider)
                                    .listOfFifteenCities![index];
                                return ListTile(
                                  onTap: () async {
                                    await ref
                                        .read(homeModelProvider)
                                        .modifyFavouriteLists(
                                            nameOfOldCity: oldCityName,
                                            nameOfNewCity: item.city!);
                                    context.pop();
                                  },
                                  title: Text(
                                    item.city!,
                                    style: AppTextStyle.bodyThree,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                thickness: 1,
                                color: AppColors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
