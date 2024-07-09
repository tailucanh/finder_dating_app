import 'package:chat_app/app/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.title,
        this.icon,
      this.onTap,
      this.isBorder = false,});

  final bool isBorder;
  final String title;
  final String? icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.w),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: isBorder ? Colors.white : AppColors.primaryColor,
            border: isBorder
                ? Border.all(width: 1, color: AppColors.primaryColor)
                : null),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: (icon != null) ? MainAxisAlignment.start : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (icon != null) ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(icon!,width: 20,),
            ) : const SizedBox(),
            Expanded(
              child: Text(title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: isBorder ? Colors.black : Colors.white),
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
