import 'package:chat_app/app/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget ItemReportSelect(
    {required String title, bool state = false, Function()? onTap}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width:state ? 2: 1, color: state ? AppColors.primaryColor : Colors.grey.shade400),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Text(title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            state ? Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Icon(Icons.check_rounded, color: AppColors.primaryColor,size: 25,),
            ) : SizedBox(),
          ],
        ),
      ),
    );
