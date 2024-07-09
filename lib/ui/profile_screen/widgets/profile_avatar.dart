import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.avatarUrl,
    required this.onEdit,
    required this.onDetail,
  });

  final String avatarUrl;
  final Function() onEdit;
  final Function() onDetail;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onDetail,
          child: Center(
            child: Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: CachedNetworkImage(
                    imageUrl: avatarUrl,
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
        ),
        Positioned.fill(
          child: InkWell(
            onTap: onDetail,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.redAccent,
                  width: 5,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 15,
          right: MediaQuery.of(context).size.width / 3.9,
          child: InkWell(
            onTap: onEdit,
            child: Container(
              width: 45,
              height: 45,
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                  color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade900,
                boxShadow: [
                  BoxShadow(
                  color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade300 : Colors.grey.shade900,
                    blurRadius: 2
                  ),
                ]
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}