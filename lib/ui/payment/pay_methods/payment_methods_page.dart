import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/services/purchase_api.dart';
import 'package:chat_app/ui/payment/payment_cubit.dart';
import 'package:chat_app/ui/payment/payment_navigater.dart';
import 'package:chat_app/ui/widgets/popup_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';


class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key, required this.cubit});

   final PaymentCubit cubit;

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageChildPageState();
}

class _PaymentMethodsPageChildPageState extends State<PaymentMethodsPage> {

  bool _isExpandedPayGoogle = false;


  @override
  void initState() {
    super.initState();
    print('${widget.cubit.state.totalPrice}');
    widget.cubit.fetchOffers();
  }

  @override
  Widget build(BuildContext context) {
    print("Price gg: ${HelpersDataUser.getPriceByPackage(price: widget.cubit.state.totalPrice, listPackage: widget.cubit.state.listPackages ?? [])}");

    return WillPopScope(
      onWillPop: () async {
        if(_isExpandedPayGoogle){
          setState(() {
            _isExpandedPayGoogle = false;
          });
        }else {
          context.pop();
        }
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: _buildBodyWidget(),
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          if(!_isExpandedPayGoogle){
                            context.pop();
                          }else{
                            setState(() {
                              _isExpandedPayGoogle = false;
                            });
                          }
                        },
                        child: !_isExpandedPayGoogle ? SvgPicture.asset(
                          'delete'.withIcon(),
                          width: 20,
                          colorFilter:
                          const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                        ) : Icon(Icons.arrow_back_rounded, size: 25,),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      S().paymentMethodsTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),

                ],
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 35),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade300 : Colors.grey.shade800,
                ),
                child: Column(
                  children: [

                    !_isExpandedPayGoogle ?
                    InkWell(
                      onTap: (){
                        widget.cubit.paymentPaypal(context, total: widget.cubit.state.totalPrice.toString(), turn: widget.cubit.state.turn, priority: widget.cubit.state.priority);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 25, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black87, width:  1.5),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Image.asset('paypal_2'.withIconPNG(),width: 25,) ,
                                ),
                                Text("PayPal",style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500
                                ),)
                              ],
                            ),
                            Icon(Icons.keyboard_arrow_right_outlined,color: Theme.of(context).brightness == Brightness.light
                                ? Colors.black : Colors.white, size: 35,)
                          ],
                        ),
                      ),
                    ) : const SizedBox(),
                    !_isExpandedPayGoogle ?
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ) : const SizedBox(),
                    InkWell(
                      onTap: (){
                        setState(() {
                          _isExpandedPayGoogle = true;
                        });
                      },
                      child: Padding(
                        padding:  EdgeInsets.only(top: !_isExpandedPayGoogle ? 25 : 0, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black87, width: 1.5),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Image.asset('google-play'.withIconPNG(),width: 25,) ,
                                ),
                                Text("Google Play",style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500
                                ),)
                              ],
                            ),
                            Icon(Icons.keyboard_arrow_right_outlined,color: Theme.of(context).brightness == Brightness.light
                                ? Colors.black : Colors.white, size: 35,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _isExpandedPayGoogle ? AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
              padding: EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade300 : Colors.grey.shade800,
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black87 : Colors.grey,
                      )
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5, right: 10, left: 10),
                          child: Row(
                            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${widget.cubit.state.turn } ${S().paymentMethods_GooglePlay_Title}: ',style: TextStyle(fontSize: 16),),

                              Text('${HelpersDataUser.formatCurrency(widget.cubit.state.totalPrice * 24260)} \đ/M',style: TextStyle(fontSize: 16),),

                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, right: 10, left: 10),
                          child: Row(
                            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${S().paymentMethods_GooglePlay_Total}: ',style: TextStyle(fontSize: 16),),

                              ((widget.cubit.state.listPackages ?? []).isEmpty) ?
                              Text('${HelpersDataUser.formatCurrency(widget.cubit.state.totalPrice * 24260)} \đ + ${S().paymentMethods_GooglePlay_Tax} ',style: TextStyle(fontSize: 16),):
                              Text('${HelpersDataUser.getPriceByPackage(price: widget.cubit.state.totalPrice, listPackage: widget.cubit.state.listPackages ?? [])} + ${S().paymentMethods_GooglePlay_Tax} ',style: TextStyle(fontSize: 16),),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(S().paymentMethods_GooglePlay_Content,style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () async {
                      if((widget.cubit.state.listPackages ?? []).isNotEmpty){
                        final isSuccess = await PurchaseApi.purchasesPackage(HelpersDataUser.getPackageByPrice(price: widget.cubit.state.totalPrice, listPackage: widget.cubit.state.listPackages ?? [])!);
                        if(!isSuccess){
                          AppPopupNotification.dialogErrorSystem(context: context, content: S().paymentMethods_GooglePlay_Error, onTryAgain: () {Navigator.pop(context); });

                        }else {
                          widget.cubit.paymentGooglePlay(total: HelpersDataUser.getPriceByPackage(price: widget.cubit.state.totalPrice, listPackage: widget.cubit.state.listPackages ?? []), turn: widget.cubit.state.turn, priority: widget.cubit.state.priority);
                          context.goNamed(AppRoutes.main);

                        }
                      }

                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                      padding: EdgeInsets.symmetric(vertical: 13),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(0, 84, 153, 1.0),
                            Color.fromRGBO(63, 127, 218, 1.0)],
                        ),
                      ),
                      child: Text(S().paymentMethods_GooglePlay_Button, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),textAlign: TextAlign.center,),
                    ),
                  )
                ],
              ),
          ) : const SizedBox()


        ],
      )
    );
  }

  @override
  void dispose() {

    super.dispose();
  }
}
