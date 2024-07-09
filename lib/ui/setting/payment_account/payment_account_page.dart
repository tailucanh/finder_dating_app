import 'package:chat_app/app/app_color.dart';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/services/purchase_api.dart';
import 'package:chat_app/ui/payment/payment_cubit.dart';
import 'package:chat_app/ui/payment/payment_navigater.dart';
import 'package:chat_app/ui/widgets/app_bar.dart';
import 'package:chat_app/ui/widgets/popup_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';


class PaymentAccountPage extends StatefulWidget {
  const PaymentAccountPage({super.key});


  @override
  State<PaymentAccountPage> createState() => _PaymentAccountChildPageState();
}

class _PaymentAccountChildPageState extends State<PaymentAccountPage> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PrimaryAppBar(
        context: context,
        text: S.current.paymentAccountManagerTitle,
        sizeText: 17,
        center: false,
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.black700
            : Colors.grey.shade200,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [

              Align(
                alignment: Alignment.centerLeft,
                  child: Text(S().paymentAccountManagerContent, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white : Colors.black,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                            print('Thêm thẻ ngân hàng');
                      },
                      child: Container(
                        padding: EdgeInsets.only(top:8, bottom: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black87, width: 1),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Icon(Icons.credit_card_rounded, size: 30,) ,
                                  ),
                                  Text(S().paymentAccountManager_Card,style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_right_outlined,color: Theme.of(context).brightness == Brightness.light
                                ? Colors.black : Colors.white, size: 30,)
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    InkWell(
                      onTap: (){
                        print('Thêm paypal');
                      },
                      child: Container(
                        padding: EdgeInsets.only(top:25, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black87, width: 1),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Image.asset('paypal_2'.withIconPNG(),width: 25,) ,
                                  ),
                                  Text(S().paymentAccountManager_Paypal,style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_right_outlined,color: Theme.of(context).brightness == Brightness.light
                                ? Colors.black : Colors.white, size: 30,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(S().paymentAccountManagerSupportTitle, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 8),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white : Colors.black,
                ),
                child: InkWell(
                  onTap: (){
                    print('Trợ giúp');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(S().paymentAccountManagerSupportContent,style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_right_outlined,color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black : Colors.white, size: 30,)
                    ],
                  ),
                ),
              ),

              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(S().paymentAccountManagerSupportContent_2, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),)),
            ],
          ),

        ],
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
