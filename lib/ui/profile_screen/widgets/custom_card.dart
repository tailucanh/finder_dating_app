import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool isIcon;

  const CustomCard({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    this.iconColor,
    required this.onTap,
    required this.isIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(5),
            width: 110,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isIcon ? Icon(icon, size: 25, color: iconColor,)
                    : Image.asset('ic_tinder_logo'.withImage(), width: 25),
                const SizedBox(height: 6),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.center,
                    title,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                ),
                const SizedBox(height: 3),
                Expanded(
                  child: Text(
                    subtitle ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: iconColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -8,
            right: -5,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: Colors.grey,
                  size: 24,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
