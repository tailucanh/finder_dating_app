import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/model/package_binder_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app_color.dart';
import 'custom_package_card.dart';

class BottomModalFullScreen extends StatelessWidget {
  final Color color;
  final Color? iconColor;
  final String title;
  final String subTitle;
  final bool isHaveColor;
  final bool isHaveIcon;
  final bool isSuperLike;
  final String? assetsBanner;
  final String? assetsIcon;
  final IconData? iconData;
  final List<PackageModel>? packageModel;

  const BottomModalFullScreen(
      {super.key,
        required this.color,
        required this.title,
        required this.subTitle,
        required this.isHaveColor,
        this.assetsBanner,
        required this.isHaveIcon,
        this.iconData,
        this.iconColor,
        this.assetsIcon,
        this.packageModel,
        required this.isSuperLike});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    TextStyle styleTextSpan = TextStyle(color: Theme.of(context).brightness == Brightness.light ? Colors.black: Colors.white, fontSize: 12);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade200 : AppColors.black700,
              ),
              margin:const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: height / 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      subTitle,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      S().pageFunctionVipContent1,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: height / 4.5,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: packageModel!.length,
                        itemBuilder: (context, index) {
                          final package = packageModel![index];
                          return CustomPackageCard(packageModel: package);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: double.parse('${height / 2}'),
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.grey, width: 0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Positioned(
                          top: -10,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.5),
                                child: Text(
                                  S().pageFunctionVipContent2,
                                  style: const TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.8),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30.0, horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              buildRowTitle(S().pageFunctionVipContent3),
                              buildRowTitle(S().pageFunctionVipContent4)
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  height: height / 4.8,
                  decoration:  BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                      border: const Border(
                          top: BorderSide(color: Colors.grey, width: 0.8))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            text: S().pageFunctionVipContent5,
                            style: styleTextSpan,
                            children: [
                              TextSpan(
                                text: S().pageFunctionVipContent6,
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: S().pageFunctionVipContent7)
                            ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shadowColor: color,
                              fixedSize: const Size(250, 50),
                              backgroundColor: color,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          onPressed: () {},
                          child: Text(
                            S().pageFunctionVipNextButton,
                            style: TextStyle(
                                color: color == Colors.black
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 50,
                child: Stack(
                  children: [
                    Container(
                      height: 50,
                      decoration: isHaveColor ? BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [color.withOpacity(0.5), Theme.of(context).brightness == Brightness.light ? Colors.grey.shade200 : AppColors.black700],
                        ),
                      ) : const BoxDecoration(
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child:  Padding(
                        padding:  const EdgeInsets.only(left: 8.0),
                        child: IconButton(
                          icon:  SvgPicture.asset('delete'.withIcon(),width: 20,),
                          onPressed: context.pop,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child:Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          isHaveIcon
                              ? Icon(
                            iconData,
                            color: iconColor,
                          )
                              : Image.asset(assetsIcon!, width: 25),
                          const SizedBox(width: 5),
                          Text(
                            title,
                            style:  TextStyle(
                              fontSize:title.length < 7 ? 23 : 18,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(width: 5),
                          (!isHaveIcon &&(assetsBanner ?? "").isNotEmpty) ? SvgPicture.asset(
                            assetsBanner ?? '',
                            width: 40,
                          ): const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )

          ],
        ));
  }

  Widget buildRowTitle(String title) {
    return Row(
      children: [
        const Icon(
          Icons.check,
          size: 29,
          color: Colors.grey,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
        )
      ],
    );
  }
}
