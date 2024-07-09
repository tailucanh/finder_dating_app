import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app_setting/app_setting_cubit.dart';

class CardSettingCustom extends StatelessWidget {
  final String? assetsIcon;
  final String? assetsBanner;
  final String subTitle;
  final String? title;
  final double width;
  final bool? isHaveIcon;
  final IconData? iconData;
  final Function() onTap;
  final Color? iconColor;
  final AppSettingCubit cubit;

  const CardSettingCustom(
      {super.key,
      required this.cubit,
      this.assetsIcon,
      this.assetsBanner,
      required this.subTitle,
      required this.onTap,
      required this.width,
      this.isHaveIcon,
      this.iconData,
      this.iconColor,
      this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:  const EdgeInsets.only(top: 5,left: 10,right: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
             borderRadius: BorderRadius.circular(8),
          ),
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isHaveIcon!
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                  )
                                ]
                              ),
                              padding: const EdgeInsets.all(5),
                              alignment: Alignment.center,
                              child: Icon(
                                iconData,
                                color: iconColor,
                                size: 20,
                              ),
                            )
                          : Image.asset(assetsIcon!, width: 25, height: 25,),
                      const SizedBox(
                        width: 4,
                      ),
                      if (title == null)
                         Text(
                          "Finder",
                          style: TextStyle(
                            fontSize: 22,
                            color: cubit.state.themeMode == ThemeMode.light ? Colors.black : Colors.white,
                            fontFamily: "Kanit",
                          ),
                        ),
                      const SizedBox(
                        width: 2,
                      ),
                      if (!isHaveIcon!)
                        SvgPicture.asset(
                          assetsBanner!,
                          width: 64,
                          height: 20,
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: isHaveIcon! ? iconColor
                          :  cubit.state.themeMode == ThemeMode.light ? Colors.black : Colors.white,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
