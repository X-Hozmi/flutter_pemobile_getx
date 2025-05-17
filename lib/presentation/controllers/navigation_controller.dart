import 'package:flutter_pemobile_getx/utils/constant.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  var tabIndex = 0.obs;
  var currentRoute = Routes.homePage.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
    switch (index) {
      case 0:
        currentRoute.value = Routes.homePage;
        break;
      case 1:
        currentRoute.value = Routes.listPage;
        break;
      case 2:
        currentRoute.value = Routes.profilePage;
        break;
      case 3:
        currentRoute.value = Routes.cvPage;
        break;
    }
  }
}
