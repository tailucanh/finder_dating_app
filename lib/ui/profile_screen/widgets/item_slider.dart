import 'package:chat_app/model/item_slider.dart';
import 'package:flutter/material.dart';

class ItemSliderCustom extends StatelessWidget {
  final ItemSlider itemSlider;

  const ItemSliderCustom({super.key, required this.itemSlider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                itemSlider.image,
                width: 30,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                itemSlider.title,
                overflow: TextOverflow.ellipsis,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            itemSlider.subTitle,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
