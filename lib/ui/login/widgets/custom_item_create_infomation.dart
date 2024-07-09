import 'package:chat_app/app/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget ItemInformation(
        {required String title, bool state = false, Function()? onTap}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(width: 1, color: AppColors.primaryColor),
          color: !state ? Colors.white : AppColors.primaryColor,
        ),
        child: Text(title,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16.sp,
              color: state ? Colors.white : AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            )),
      ),
    );
