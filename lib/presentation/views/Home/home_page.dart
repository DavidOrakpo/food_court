import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_court/core/Utilities/Shared%20Preferences/shared_pref.dart';
import 'package:food_court/presentation/styles/app_colors.dart';
import 'package:food_court/presentation/styles/spacing.dart';
import 'package:food_court/presentation/views/Home/View%20Model/home_viewModel.dart';
import 'package:food_court/presentation/views/Home/widgets/app_bar.dart';
import 'package:food_court/presentation/views/Home/widgets/details.dart';
import 'package:food_court/presentation/views/Home/widgets/main_info_tile.dart';
import 'package:food_court/presentation/views/Home/widgets/watch_list.dart';

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
    // await AppSharedPreferences()
    //     .init()
    //     .then((value) => AppSharedPreferences().preferencesInstance!.clear());
    await AppSharedPreferences()
        .init()
        .then((value) => ref.read(homeModelProvider).initialize());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0, 0.65, 1],
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
              children: const [
                CustomAppBar(),
                Divider(
                  thickness: 1,
                  color: AppColors.white,
                ),
                MainInfoTile(),
                Padding(
                  padding: AppSpacings.horizontalPadding,
                  child: Divider(
                    thickness: 1,
                    color: AppColors.white,
                  ),
                ),
                DetailsTile(),
                Padding(
                  padding: AppSpacings.horizontalPadding,
                  child: Divider(
                    thickness: 1,
                    color: AppColors.white,
                  ),
                ),
                WatchListTile(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
