import 'package:demoapp/Constant/Constant.dart';
import 'package:demoapp/Controller/HomeController.dart';
import 'package:demoapp/Model/UserModel.dart';
import 'package:demoapp/Screen/DetailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final controller = Get.put(HomeController());

  final ScrollController scrollController = ScrollController();

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contect List'),
          automaticallyImplyLeading: false,
        ),
        body: Obx(() {

          return (controller.IsLoading.value) ?
          Center(child: CircularProgressIndicator(),) : Padding(
            padding:  EdgeInsets.only(top: 1.5.h),
            child: ListView.separated(
              controller: controller.scrollController,
              itemCount: controller.userdata.length,
              itemBuilder: (BuildContext context, int index){
                UserModel data = controller.userdata[index];

                if(index == controller.userdata.length){
                  return Center(child: CupertinoActivityIndicator(),);
                }
                return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      Get.to(DetailScreen(
                        userModel: controller.userdata[index],
                        index: index,
                      ));
                    },
                    child: listWidget(controller.userdata[index], index,
                            (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return Container(
                                  child: Center(
                                    child: Container(
                                      height: 40.h,
                                      width: 80.w,
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Image.network(data.avatar, height: 35.h, width: 80.w, fit: BoxFit.fill,),
                                          Expanded(
                                            child: Material(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                      onTap: (){
                                                        Get.back();
                                                        Get.to(DetailScreen(
                                                          userModel: controller.userdata[index],
                                                        ));
                                                      },
                                                      child: Icon(Icons.info_outline_rounded,)
                                                  ),
                                                  GestureDetector(
                                                      onTap: () async{
                                                        Get.back();
                                                        final Uri emailLaunchUri = Uri(
                                                          scheme: 'mailto',
                                                          path: data.email,
                                                          query: encodeQueryParameters(<String, String>{
                                                            'subject': 'Flutter Demo',
                                                            'body' : '${data.first_name} ${data.last_name}\n${data.email}\n\n${data.avatar}'
                                                          }),
                                                        );

                                                        await launchUrl(emailLaunchUri);
                                                      },
                                                      child: Icon(Icons.email_outlined,)
                                                  ),
                                                  GestureDetector(
                                                      onTap: (){
                                                        //Get.back();
                                                        Share.share('${data.first_name} ${data.last_name}\n${data.email}\n\n${data.avatar}');
                                                      },
                                                      child: Icon(Icons.share,)
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                          );
                        })
                );
              }, separatorBuilder: (BuildContext context, int index) {
              return Divider( thickness: 0.1.h, color: Colors.black,);
            },
            ),
          );
        })
    );
  }

  Widget listWidget(UserModel userdata, int index, VoidCallback ontap){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  ontap();
                },
                child: Hero(
                  tag: 'image$index',
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      child: Image.network(userdata.avatar, fit: BoxFit.cover,),
                      size: Size.fromRadius(30),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4.w,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Custome(userdata.first_name),
                        SizedBox(width: 1.w,),
                        Custome(userdata.last_name),
                      ],
                    ),
                    SizedBox(height: 0.5.h,),
                    Text(userdata.email,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.grey
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 2.w,),
              Icon(Icons.arrow_forward_ios_rounded, size: 3.5.h, color: Colors.grey,)
            ],
          ),
        ),
      ],
    );
  }
}
