import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pemobile_getx/app_router.dart';
import 'package:flutter_pemobile_getx/presentation/controllers/auth_controller.dart';
import 'package:flutter_pemobile_getx/presentation/controllers/navigation_controller.dart';
import 'package:flutter_pemobile_getx/shared/named_nav_bar_item_widget.dart';
import 'package:flutter_pemobile_getx/utils/constant.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class NavigationPage extends StatefulWidget {
  final Widget screen;

  const NavigationPage({super.key, required this.screen});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  DateTime? _lastBackPressedTime;
  final AuthController authController = Get.find<AuthController>();
  final NavigationController navigationController =
      Get.find<NavigationController>();

  final List<NamedNavigationBarItemWidget> tabs = [
    NamedNavigationBarItemWidget(
      initialLocation: 'home',
      icon: const Icon(Icons.home),
      label: 'Home',
    ),
    NamedNavigationBarItemWidget(
      initialLocation: 'list',
      icon: const Icon(Icons.list),
      label: 'List',
    ),
    NamedNavigationBarItemWidget(
      initialLocation: 'profile',
      icon: const Icon(Icons.person),
      label: 'Profile',
    ),
    NamedNavigationBarItemWidget(
      initialLocation: 'cv',
      icon: const Icon(Icons.document_scanner),
      label: 'CV',
    ),
  ];

  bool _isMainNavigationPage(String location) {
    final mainPages = [
      Routes.homePage,
      Routes.listPage,
      Routes.profilePage,
      Routes.cvPage,
    ];

    return mainPages.any((page) => location == page);
  }

  void _handleBackPress() {
    final now = DateTime.now();

    if (_lastBackPressedTime == null ||
        now.difference(_lastBackPressedTime!) > const Duration(seconds: 2)) {
      _lastBackPressedTime = now;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tekan sekali lagi untuk keluar'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final RouteMatch lastMatch =
        goRouter.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList =
        lastMatch is ImperativeRouteMatch
            ? lastMatch.matches
            : goRouter.routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    log('Location: $location');

    final bool isMainNavPage = _isMainNavigationPage(location);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (isMainNavPage) {
          _handleBackPress();
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: widget.screen,
        bottomNavigationBar: _buildBottomNavigation(context),
        floatingActionButton:
            (!location.contains(Routes.listPage))
                ? Obx(
                  () => FloatingActionButton(
                    key: const Key('navigationPageFloatingActionButton'),
                    onPressed: () {
                      if (!location.contains(Routes.listPage)) {
                        authController.logout();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('On Development, please wait...'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    child:
                        (!location.contains(Routes.listPage))
                            ? authController.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Icon(Icons.logout)
                            : const Icon(Icons.edit),
                  ),
                )
                : null,
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        key: const Key('navigationPageBottomNavigation'),
        onTap: (value) {
          if (navigationController.tabIndex.value != value) {
            navigationController.changeTabIndex(value);
            context.goNamed(tabs[value].initialLocation);
          }
        },
        elevation: 10,
        selectedIconTheme: IconThemeData(
          color: const Color.fromRGBO(0, 107, 179, 1),
          size: ((IconTheme.of(context).size)! * 1.3),
        ),
        items: tabs,
        currentIndex: navigationController.tabIndex.value,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
