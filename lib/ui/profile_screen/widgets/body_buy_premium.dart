import 'package:chat_app/app/app_color.dart';
import 'package:chat_app/ui/profile_screen/widgets/bottom_modal.dart';
import 'package:chat_app/ui/profile_screen/widgets/custom_card.dart';
import 'package:chat_app/ui/profile_screen/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/generated/l10n.dart';

import '../../../config/helpers/helpers_data_user.dart';
import '../../widgets/popup_notification.dart';

class BodyBuyPremium extends StatefulWidget {
  const BodyBuyPremium({super.key});

  @override
  State<BodyBuyPremium> createState() => _BodyBuyPremiumState();
}

class _BodyBuyPremiumState extends State<BodyBuyPremium> {
  void _showModal() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => const BottomModal());
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade200 : AppColors.black700
      ),
      padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 70),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CustomCard(
                  onTap: () =>  AppPopupNotification.showBottomModalVip(
                    context: context,
                    packageModel: HelpersDataUser.packageBinderSuperLike(context),
                    isSuperLike: true,
                    isHaveColor: true,
                    iconData: Icons.star,
                    isHaveIcon: true,
                    iconColor: Colors.blue,
                    color: Colors.blue[200]!,
                    title: S().bodyBuyPremiumTitle,
                    subTitle: S().bodyBuyPremiumContent,
                  ),
                  iconColor: Colors.blue,
                  icon: Icons.star,
                  title: S().bodyBuyPremiumContentSuperLikesText,
                  subtitle: S().bodyBuyPremiumButtonText,
                  isIcon: true,
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CustomCard(
                  isIcon: true,
                  onTap: _showModal,
                  iconColor: Colors.purple,
                  icon: Icons.bolt,
                  title: S().bodyBuyPremiumContentSuperBoostsText,
                  subtitle: S().bodyBuyPremiumButtonText,
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CustomCard(
                  isIcon: false,
                  onTap: () {},
                  title: S().bodyBuyPremiumSubscriptionText,
                ),
              ),
            ],
          ),
          const SliderCustom(),
        ],
      ),
    );
  }
}
