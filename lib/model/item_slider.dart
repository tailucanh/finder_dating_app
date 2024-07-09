import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class ItemSlider {
  final Color color;
  final String image, title, subTitle;
  final int id;

  ItemSlider(
      {required this.color,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.id});
}

List<ItemSlider> sliderList(BuildContext context) {
  return [
    ItemSlider(
        color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
        image: 'ic_tinder_logo'.withImage(),
        title: S().sliderItemTitle1,
        subTitle: S().sliderItemSubTitle1,
        id: 1),
    ItemSlider(
        color: const Color.fromRGBO(216, 189, 57, 1.0),
        image: 'ic_tinder_logo'.withImage(),
        title: S().sliderItemTitle2,
        subTitle: S().sliderItemSubTitle2,
        id: 2),
    ItemSlider(
        color: const Color.fromRGBO(242, 73, 86, 1),
        image: 'ic_tinder_logo'.withImage(),
        title: S().sliderItemTitle3,
        subTitle: S().sliderItemSubTitle3,
        id: 3),
  ];
}
