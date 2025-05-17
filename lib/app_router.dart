import 'package:flutter/widgets.dart';
import 'package:flutter_pemobile_getx/presentation/controllers/navigation_controller.dart';
import 'package:flutter_pemobile_getx/presentation/pages/cv/cv_page.dart';
import 'package:flutter_pemobile_getx/presentation/pages/home/home_page.dart';
import 'package:flutter_pemobile_getx/presentation/pages/list/list_page.dart';
import 'package:flutter_pemobile_getx/presentation/pages/login/login_page.dart';
import 'package:flutter_pemobile_getx/presentation/pages/navigation/navigation_page.dart';
import 'package:flutter_pemobile_getx/presentation/pages/profile/profile_page.dart';
import 'package:flutter_pemobile_getx/presentation/pages/unknown_page.dart';
import 'package:flutter_pemobile_getx/user_activity_handler.dart';
import 'package:flutter_pemobile_getx/utils/constant.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: Routes.loginPage,
  navigatorKey: GlobalKey<NavigatorState>(),
  routes: [
    /// Route for the login page.
    GoRoute(
      name: 'login',
      path: Routes.loginPage, // URL path for the login page.
      builder: (context, state) => const LoginPage(), // Widget to display.
    ),

    ShellRoute(
      /// A navigator key to manage nested navigation within the shell.
      navigatorKey: GlobalKey<NavigatorState>(),

      /// The shell's builder that wraps child pages.
      builder: (context, state, child) {
        return GetBuilder<NavigationController>(
          /// Provides a [NavigationCubit] to manage navigation state within the shell.
          init: NavigationController(),

          /// Handles user activity timeouts and renders the child navigation page.
          builder: (_) {
            return UserActivityHandler(
              timeout: const Duration(
                minutes: 10,
              ), // Timeout duration for user activity.
              child: NavigationPage(screen: child), // Main navigation screen.
            );
          },
        );
      },

      /// Nested routes within the shell.
      routes: [
        /// Route for the home page.
        GoRoute(
          name: 'home', // Named route for identification.
          path: Routes.homePage, // URL path for the home page.
          builder: (context, state) => HomePage(), // Widget to display.
        ),

        /// Route for the list page.
        GoRoute(
          name: 'list', // Named route for identification.
          path: Routes.listPage, // URL path for the list page.
          builder: (context, state) => ListPage(), // Widget to display.
        ),

        /// Route for the profile page.
        GoRoute(
          name: 'profile', // Named route for identification.
          path: Routes.profilePage, // URL path for the profile page.
          builder: (context, state) => ProfilePage(), // Widget to display.
        ),

        /// Route for the cv page.
        GoRoute(
          name: 'cv', // Named route for identification.
          path: Routes.cvPage, // URL path for the cv page.
          builder: (context, state) => CVPage(), // Widget to display.
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const UnknownPage(),
);
