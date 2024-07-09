import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:flutter/material.dart';

class AppCacheAvatar extends StatelessWidget {
  const AppCacheAvatar(
      {super.key, this.status = false, this.linkAvatar,this.activeTime, this.size = 80, this.isCardStory = false});
  final String? linkAvatar;
  final int? activeTime;
  final bool status;
  final double size;
  final bool isCardStory;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 1),
        borderRadius: BorderRadius.circular(90),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(size / 2),
            child: CachedNetworkImage(
              imageUrl: linkAvatar ?? "",
              key: UniqueKey(),
              width: size,
              height: size,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey,
              ),
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
          (!status && activeTime != null) ? Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 30,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white : Colors.black,
                    width: 2,
                  ),
                  color: Colors.green.shade300,
                ),
                child: Text(HelpersDataUser.strAcronymCalculateTimeDifference(activeTime ?? 0) != 0 ? HelpersDataUser.strAcronymCalculateTimeDifference(activeTime ?? 0): '',
                style: const TextStyle(fontSize: 10, color: Colors.black,fontWeight: FontWeight.w500),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),
              )) : const SizedBox(),

          status
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: isCardStory ? 10: 20,
                    height: isCardStory ? 10: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                      color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white : Colors.black,
                        width: isCardStory ? 1 : 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.green,
                    ),
                  ))
              : const SizedBox(),
        ],
      ),
    );
  }
}
