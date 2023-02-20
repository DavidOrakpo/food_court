import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_court/core/Utilities/Validators/validator.dart';
import 'package:food_court/presentation/components/custom_drop_down_menu.dart';
import 'package:food_court/presentation/styles/app_colors.dart';
import 'package:food_court/presentation/styles/spacing.dart';
import 'package:food_court/presentation/styles/text_styles.dart';
import 'package:food_court/presentation/views/Home/View%20Model/home_viewModel.dart';
import 'package:collection/collection.dart';
import 'package:food_court/presentation/views/Home/home_viewmodel.dart';
import 'package:food_court/presentation/views/Home/widgets/header_tile.dart';
import 'package:food_court/presentation/views/Home/widgets/selected_day_tile.dart';
import 'package:food_court/presentation/views/Home/widgets/time_breakdown_tile.dart';

class HomePage extends ConsumerStatefulWidget {
  static const routeIdentifier = "HOME_PAGE";
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String? defaultDropDownValue = "Lagos";
  @override
  void initState() {
    _fetchData();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await ref.read(homeProvider).initialize();
    // });
    super.initState();
  }

  Future<void> _fetchData() async {
    await ref.read(homeModelProvider).initialize();
  }

  @override
  Widget build(BuildContext context) {
    var provider = ref.watch(homeModelProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0, 0.5, 1],
            colors: [
              AppColors.primary.withOpacity(1),
              AppColors.primaryGradient2,
              AppColors.primaryGradient3,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: AppSpacings.verticalPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    Expanded(
                      flex: 4,
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 150,
                          child: InfoDropDown(
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
                            onChanged: (value) {
                              setState(() {
                                defaultDropDownValue = value;
                              });
                            },
                            items: provider.isLoading
                                ? null
                                : provider.listOfFifteenCities!
                                    .mapIndexed((index, element) {
                                    return DropdownMenuItem(
                                      value: element.city,
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                    const Expanded(
                      child: Icon(
                        Icons.gps_fixed,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                  color: AppColors.white,
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: AppSpacings.horizontalPadding,
                  child: AnimatedOpacity(
                    duration: const Duration(
                      seconds: 1,
                    ),
                    opacity: provider.isLoading ? 0 : 1,
                    child: Text(
                      "${provider.chosenCity?.city!}",
                      style: AppTextStyle.headerFour
                          .copyWith(color: AppColors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: provider.isLoading ? 20 : 0,
                ),
                Padding(
                  padding: AppSpacings.horizontalPadding,
                  child: AnimatedOpacity(
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
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: AppSpacings.horizontalPadding,
                  child: Text(
                    Validators.dateTimeToString(
                        DateTime.fromMillisecondsSinceEpoch(
                            provider.chosenCityWeatherForcast!.dt!)),
                    style: AppTextStyle.headerFive.copyWith(
                      color: AppColors.textGray,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.red,
                    child: const Center(child: Text("Test")),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.amber,
                    child: const Center(child: Text("Test")),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
