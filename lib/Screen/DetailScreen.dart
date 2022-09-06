import 'package:demoapp/Constant/Constant.dart';
import 'package:demoapp/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DetailScreen extends StatefulWidget {
   DetailScreen({Key? key,
     this.index,
     this.userModel
  }) : super(key: key);

  int? index;
  UserModel? userModel;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>{

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 6.h,),
            Hero(
              tag: 'image${widget.index}',
              child: ClipOval(
                child: SizedBox.fromSize(
                  child: Image.network(widget.userModel!.avatar!, fit: BoxFit.cover,),
                  size: Size.fromRadius(13.h),
                ),
              ),
            ),
            SizedBox(height: 2.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Custome(widget.userModel!.first_name),
                SizedBox(width: 2.w,),
                Custome(widget.userModel!.last_name)
              ],
            ),
            SizedBox(height: 1.h,),
            Custome(widget.userModel!.email)
          ],
        ),
      ),
    );
  }
}
