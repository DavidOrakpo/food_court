import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_court/presentation/components/custom_drop_down_menu.dart';
import 'package:food_court/presentation/styles/app_colors.dart';
import 'package:food_court/presentation/styles/spacing.dart';
import 'package:food_court/presentation/styles/text_styles.dart';
import 'package:food_court/presentation/views/Home/View%20Model/home_viewModel.dart';

class CustomAppBar extends ConsumerStatefulWidget {
  const CustomAppBar({super.key});

  @override
  ConsumerState<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  String? defaultDropDownValue = "Lagos";
  @override
  Widget build(BuildContext context) {
    var provider = ref.watch(homeModelProvider);
    return Padding(
      padding: AppSpacings.horizontalPadding,
      child: Row(
        children: [
          const Expanded(child: SizedBox()),
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 150,
                child: provider.isLoading
                    ? SizedBox(
                        height: 45,
                        child: Center(
                          child: Text(
                            "Getting Ready...",
                            style: AppTextStyle.headerOne.copyWith(
                              fontSize: provider.isLoading ? 14 : 40,
                              color: AppColors.white,
                              height: 1,
                            ),
                          ),
                        ),
                      )
                    : InfoDropDown(
                        iconColor: AppColors.white,
                        dropdownvalue: defaultDropDownValue,
                        dropDownColor: AppColors.primary,
                        selectedItemBuilder: (p0) {
                          return provider.listOfFifteenCities!.mapIndexed(
                            (index, element) {
                              return Container(
                                alignment: Alignment.centerLeft,
                                // constraints:
                                //     const BoxConstraints(minWidth: 100),
                                child: Text(
                                  element.city!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              );
                            },
                          ).toList();
                        },
                        borderColor: Colors.transparent,
                        hintColor: AppColors.textGray,
                        trailingWidget: const Icon(Icons.arrow_drop_down),
                        onChanged: (value) async {
                          defaultDropDownValue = value;
                          await provider.setChosenCity(value!);
                        },
                        items: provider.listOfFifteenCities!
                            .mapIndexed((index, element) {
                          return DropdownMenuItem(
                            value: element.city,
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(element.city!),
                                  const Divider(
                                    thickness: 1,
                                    color: AppColors.white,
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                await provider.getUsersCurrentPosition();
              },
              child: const Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.gps_fixed,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
