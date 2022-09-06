import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

bool IsDebug = true;

void Debug(String message){
  if(kDebugMode){
    print(message);
  }
}

Widget Custome(String data){
  return Text(data,
    textAlign: TextAlign.start,
    style: TextStyle(
      fontSize: 2.h,
      color: Colors.black,
    ),
  );
}

