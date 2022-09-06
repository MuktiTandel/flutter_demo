import 'package:demoapp/Pages/app_pages.dart';
import 'package:demoapp/Screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context,orientation,deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Contect List',
          getPages: AppPages.pages,
          initialRoute: AppPages.initial,
          theme: ThemeData(
          ),
          home: const HomeScreen(),
        );
      }
    );
  }
}

