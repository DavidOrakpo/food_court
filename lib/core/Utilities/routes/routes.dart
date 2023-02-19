import 'package:go_router/go_router.dart';
import 'package:food_court/api/models/weather_forcast/weather_model/weather_model.dart';
import 'package:food_court/core/Alerts/context.dart';
import 'package:food_court/core/Utilities/Transitions/transitions.dart';
import 'package:food_court/presentation/views/Home/home_page.dart';
import 'package:food_court/presentation/views/details/details.dart';

/// Manages the routing of pages within the app using [GoRouter]
class AppRoutes {
  AppRoutes._internal();
  static final AppRoutes _instance = AppRoutes._internal();
  factory AppRoutes() {
    return _instance;
  }

  /// The routing object that contains the list of routes for navigation.
  ///
  /// It is assigned a navigator Key [AppNavigator().navKey] to retrieve the current Build Context.
  final GoRouter router = GoRouter(
    navigatorKey: AppNavigator().navKey,
    routes: [
      GoRoute(
        path: "/",
        name: HomePage.routeIdentifier,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            name: DetailsPage.routeIdentifier,
            path: "detailsPage",
            builder: (context, state) =>
                DetailsPage(weatherModel: state.extra as WeatherModel),
            pageBuilder: (context, state) {
              return CustomSlideTransition(
                  key: state.pageKey,
                  child:
                      DetailsPage(weatherModel: state.extra as WeatherModel));
            },
          ),
        ],
      )
    ],
  );
}
