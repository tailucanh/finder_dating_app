import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_app/model/item_slider.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/generated/l10n.dart';
import '../../../config/helpers/helpers_data_user.dart';
import 'item_slider.dart';

class SliderCustom extends StatefulWidget {
  const SliderCustom({super.key});

  @override
  State<SliderCustom> createState() => _SliderCustomState();
}

class _SliderCustomState extends State<SliderCustom> {
  final _carouseController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () {},
              child: CarouselSlider(
                carouselController: _carouseController,
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                  aspectRatio: 2,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                items: sliderList(context)
                    .map((item) => ItemSliderCustom(itemSlider: item))
                    .toList(),
              ),
            ),
            Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                top: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: sliderList(context).asMap().entries.map((e) {
                    return GestureDetector(
                      child: Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentIndex == e.key
                                ? Colors.black
                                : Colors.grey),
                      ),
                    );
                  }).toList(),
                )),
          ],
        ),
        ElevatedButton(
            onPressed: () => HelpersDataUser.packageVip(
                index: sliderList(context)[currentIndex].id, context: context),
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                shadowColor: Colors.grey.shade400,
                fixedSize: const Size(250, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            child: Text(
              sliderList(context)[currentIndex].id == 1
                  ? S().sliderCustomSubTitle4
                  : sliderList(context)[currentIndex].title,
              style: TextStyle(color: sliderList(context)[currentIndex].color),
            )),
      ],
    );
  }
}
