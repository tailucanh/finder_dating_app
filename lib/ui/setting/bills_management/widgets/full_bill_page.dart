import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/model/entities/pay_entity.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_widget/ticket_widget.dart';
import '../../../../../generated/l10n.dart';


class FullBillPage extends StatefulWidget {
  const FullBillPage({
    super.key,
    required this.payEntity,
    required this.user
  });
  final PayEntity payEntity;
  final UserEntity user;

  @override
  State<FullBillPage> createState() => _FullBillPageState();
}

class _FullBillPageState extends State<FullBillPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Ink(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(238, 128, 95, 1),
                Color.fromRGBO(236, 149, 123, 1),
                Color.fromRGBO(234, 64, 128, 1),
                Color.fromRGBO(232, 98, 148, 1),
              ],
              transform: GradientRotation(pi / 4),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Ink(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => context.pop(),
                      child: const Icon(
                        Icons.close_rounded,
                        size: 25,
                        color: Colors.white,
                      )),
                  Expanded(
                    child: Center(
                      child: Ink(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.3)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                           Icon(Icons.payment_rounded,size: 30,color: Colors.white,),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              S().billDetailTitle,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Text(
             '${S().billDetailContent_1} \n ${S().billDetailContent_2}',
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
            ),
            TicketWidget(
                width: MediaQuery.of(context).size.width - 30,
                height: 430,
                margin: EdgeInsets.symmetric(vertical: 15),
                isCornerRounded: true,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(90),
                                        child: CachedNetworkImage(
                                          imageUrl: widget.user.avatar,
                                          key: UniqueKey(),
                                          fit: BoxFit.cover,
                                          fadeInCurve: Curves.fastLinearToSlowEaseIn,
                                          errorWidget: (context, url, error) => const Center(
                                            child: Icon(
                                              Icons.person_outline_rounded,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color:  Color.fromRGBO(234, 64, 128, 1),
                                          width: 5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(widget.user.fullName, style: TextStyle(fontSize: 20, color: Colors.black,fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),),
                            const SizedBox(height: 30,),
                            Container(
                              padding: const EdgeInsets.only(left: 10, right: 10,bottom: 8),
                              child: Text(widget.payEntity.id.toString(), style: TextStyle(fontSize: 15, color: Colors.black,),maxLines: 1, overflow: TextOverflow.ellipsis,),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              height: 1,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 15, right: 10,top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(S().billNameTitle, style: TextStyle(fontSize: 15, color: Colors.grey.shade700,),)),
                                  const SizedBox(width: 30,),
                                  Expanded(
                                      flex: 2,
                                      child: Text(widget.payEntity.name.toString(), style: TextStyle(fontSize: 15, color: Colors.black),maxLines: 1,)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 15, right: 10,top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(S().billPayeeTitle, style: TextStyle(fontSize: 15, color: Colors.grey.shade700,),)),
                                  const SizedBox(width: 30,),
                                  Expanded(
                                      flex: 2,
                                      child: Text(widget.payEntity.payee.toString(), style: TextStyle(fontSize: 15, color: Colors.black),maxLines: 2,)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 15, right: 10,top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(S().paymentTotalPrice, style: TextStyle(fontSize: 15, color: Colors.grey.shade700,),)),
                                  const SizedBox(width: 25,),
                                  Expanded(
                                      flex: 2,
                                      child:   Text((widget.payEntity.typePay ??'').contains('Paypal')
                                          ? (widget.payEntity.amount.toString() + " " + widget.payEntity.currency.toString()) :
                                        (widget.payEntity.amount.toString() +'' ),
                                        style: TextStyle(fontSize: 17, color: Colors.redAccent,fontWeight: FontWeight.w600),maxLines: 1,)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 15, right: 10,top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(S().billTimeTitle, style: TextStyle(fontSize: 15, color: Colors.grey.shade700,),)),
                                  const SizedBox(width: 30,),
                                  Expanded(
                                      flex: 2,
                                      child: Text(HelpersDataUser.formatBillDateTime(widget.payEntity.createTime.toString()),style: TextStyle(fontSize: 15, color: Colors.black),maxLines: 1,)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 15, right: 10,top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(S().billNameContentPay, style: TextStyle(fontSize: 15, color: Colors.grey.shade700,),)),
                                  const SizedBox(width: 30,),
                                  Expanded(
                                      flex: 2,
                                      child: Text(widget.payEntity.description.toString(),style: TextStyle(fontSize: 15, color: Colors.black),maxLines: 3,overflow: TextOverflow.ellipsis,)),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                        left: 10,
                        child:  (widget.payEntity.typePay ?? '').contains('Paypal') ?
                        Image.asset('paypal'.withIconPNG(),width: 50,) : Image.asset('google-play'.withIconPNG(),width: 40,),
                    ),
                    Positioned(
                      top: 15,
                      right: 10,
                      child:
                      Image.asset('ic_tinder_logo'.withImage(),width: 50,) ,
                    ),
                  ],
                ))


          ],
        ),
      ),

    );
  }

}