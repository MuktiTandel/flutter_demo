import 'dart:convert';

import 'package:demoapp/Constant/Constant.dart';
import 'package:demoapp/Model/UserModel.dart';
import 'package:demoapp/Service/Service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeController extends GetxController{

  List getdata = [];

  List<UserModel> userdata = [];

  int page = 0;

  HttpService httpService = HttpService();

  RxBool IsLoading = false.obs;

  int totaldata = 0;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
      Getdata();

      scrollController.addListener(() {
        pagination();
        update();
      });

  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future Getdata() async{
    try {
      IsLoading(true);
      getdata = await httpService.getPost(page + 1,10);
      totaldata = getdata.length;
      if(getdata.isNotEmpty) {
        getdata.forEach((element) {
          UserModel userModel = UserModel.fromJSON(element);
          userdata.add(userModel);
          update();
        });
      }
      update();
    } catch (e) {
      print(e);
    } finally {
      IsLoading(false);
    }
    Debug('Get user data => ${userdata.length}');
  }

  Future pagination() async{
    page++;
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(!IsLoading.value && totaldata != userdata.length){
        try {
          IsLoading(true);
          getdata.clear();
          getdata = await httpService.getPost(page + 1,10);
          totaldata = getdata.length;
          if(getdata.isNotEmpty) {
            userdata.clear();
            getdata.forEach((element) {
              UserModel userModel = UserModel.fromJSON(element);
              userdata.add(userModel);
              update();
            });
          }
        } catch (e) {
          print(e);
        } finally {
          IsLoading(false);
        }
        Debug('Get user data => ${userdata.length}');
      }
    }
  }
}