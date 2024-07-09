import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/app/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';


class BottomCallVideo extends StatefulWidget {
  final String avatar1;
  final String avatar2;
  final Widget callVideoView;

  const BottomCallVideo({super.key, required this.avatar1, required this.avatar2, required this.callVideoView});


  @override
  State<BottomCallVideo> createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomCallVideo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.3,
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            decoration:  BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : AppColors.black700,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(S().textContentCallVideo, style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,),
                  ),

                Column(
                  children: [
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 15,),
                    Stack(
                      children: [
                        Text(S().textSubmitCallVideo, style: TextStyle(fontSize: 20),),
                        widget.callVideoView,
                      ],
                    ),
                  ],
                )

              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                      border: Border.all(color:Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : AppColors.black700, width: 3),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade600,
                            blurRadius: 5,
                            offset: Offset(2,3)
                        )
                      ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: CachedNetworkImage(
                        imageUrl: widget.avatar1,
                        key: UniqueKey(),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(color: Colors.grey,),
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
                Container(
                  width: 70,
                  height: 70,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(color:Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : AppColors.black700, width: 3),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade600,
                            blurRadius: 5,
                            offset: Offset(-2,3)
                        )
                      ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: CachedNetworkImage(
                      imageUrl: widget.avatar2,
                      key: UniqueKey(),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.grey,),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
