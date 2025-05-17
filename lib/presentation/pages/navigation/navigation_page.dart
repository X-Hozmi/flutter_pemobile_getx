import 'package:flutter/material.dart';
import 'package:flutter_pemobile_getx/presentation/controllers/auth_controller.dart';
import 'package:flutter_pemobile_getx/presentation/controllers/navigation_controller.dart';
import 'package:flutter_pemobile_getx/shared/named_nav_bar_item_widget.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class NavigationPage extends StatefulWidget {
  final Widget screen;

  const NavigationPage({super.key, required this.screen});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.screen,
      bottomNavigationBar: _buildBottomNavigation(context),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          key: const Key('navigationPageFloatingActionButton'),
          onPressed: () {
            authController.logout();
          },
          child:
              authController.isLoading.value
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.logout),
        ),
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
