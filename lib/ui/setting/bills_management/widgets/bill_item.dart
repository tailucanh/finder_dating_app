import 'package:chat_app/app/app_color.dart';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/model/entities/pay_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillItem extends StatelessWidget {
  const BillItem({super.key, required this.billItem, required this.onTap});

  final PayEntity billItem;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
      padding: const EdgeInsets.only(left: 20,right: 20, top: 25,bottom: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade300
                    : Colors.grey.shade700,
                blurRadius: 5,
                offset: const Offset(2, 5)),
            BoxShadow(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade300
                    : Colors.grey.shade700,
                blurRadius: 5,
                offset: const Offset(-1.5, -3))
          ]),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (billItem.typePay ?? '').contains('Paypal') ?
                Image.asset('paypal'.withIconPNG(),width: 50,) :  Image.asset('google-play'.withIconPNG(),width: 40,),
                Text(HelpersDataUser.formatBillDateTime(billItem.createTime.toString()),
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 25,),
             Divider(
              color: Colors.grey.shade400,
              height: 1,
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(S().paymentTotalPrice,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  billItem.amount.toString() + " " + billItem.currency.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 27.sp,
                      color: AppColors.primaryColor),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
