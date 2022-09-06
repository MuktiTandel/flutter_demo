import 'package:demoapp/Pages/app_routes.dart';
import 'package:demoapp/Screen/DetailScreen.dart';
import 'package:demoapp/Screen/HomeScreen.dart';
import 'package:get/get.dart';

class AppPages{

  static const initial = Routes.home;

  static final pages = [
      GetPage(name: '/HomeScreen', page: () => HomeScreen()),
      GetPage(name: '/DetailScreen', page: () => DetailScreen()),
  ];

}