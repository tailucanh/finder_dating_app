import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/helpers/helpers_database.dart';
import '../../../generated/l10n.dart';
import '../setting_query_cubit.dart';

class BasicSearchWidget extends StatefulWidget {
  const BasicSearchWidget({
    super.key,
  });
  @override
  State<BasicSearchWidget> createState() => _BasicSearchWidgetPageState();
}

class _BasicSearchWidgetPageState extends State<BasicSearchWidget> {
  late final SettingQueryCubit _cubit;
  bool _isExpandedGender = false;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.discoverySettingPriorityText,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              Text(
                "${(helpersFunctions.maxDistance as double).toStringAsFixed(0)} km",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.red[400],
              inactiveTrackColor: Colors.grey,
              thumbColor: Colors.grey.shade100,
              overlayColor: Colors.red[400],
              secondaryActiveTrackColor: Colors.red[400],
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 2),
            ),
            child: Slider(
              value: helpersFunctions.maxDistance,
              max: 120,
              min: 20,
              divisions: 10,
              onChanged: (value) {
                setState(() {
                  helpersFunctions.maxDistance = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  S().discoverySettingShowOnly,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
              Expanded(
                flex: 1,
                child: CupertinoSwitch(
                  activeColor: Colors.red[400],
                  value: helpersFunctions.accessDistance,
                  onChanged: (newValue) {
                    setState(() {
                      helpersFunctions.accessDistance = newValue;
                    });
                  },
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _isExpandedGender = !_isExpandedGender;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S().discoverySettingShowMeText,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Text(
                            HelpersDataUser.getItemFromIndex(
                                _cubit.requestToShowList(),
                                helpersFunctions.requestToShow),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Icon(
                            _isExpandedGender
                                ? Icons.arrow_drop_up_outlined
                                : Icons.arrow_drop_down_outlined,
                            size: 25,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ],
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: _isExpandedGender ? 130 : 0.0,
                    curve: Curves.easeInOut,
                    child: _isExpandedGender
                        ? Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _cubit.requestToShowList().length,
                                itemBuilder: (context, index) {
                                  String item =
                                      _cubit.requestToShowList()[index];
                                  BorderRadius borderRadius = (index ==
                                          _cubit.requestToShowList().length - 1)
                                      ? const BorderRadius.only(
                                          bottomRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(8))
                                      : BorderRadius.circular(0);
                                  return InkWell(
                                    onTap: () async {
                                      setState(() {
                                        _isExpandedGender = !_isExpandedGender;
                                        helpersFunctions.requestToShow = index;
                                      });
                                      _cubit.updateRequestToShow();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: borderRadius,
                                          border: Border.all(
                                              color: Colors.grey.shade300,
                                              width: 0.5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          HelpersDataUser.isStringContains(
                                                  item,
                                                  HelpersDataUser.getItemFromIndex(
                                                      _cubit
                                                          .requestToShowList(),
                                                      helpersFunctions
                                                          .requestToShow))
                                              ? const Icon(
                                                  Icons.check_rounded,
                                                  size: 20,
                                                  color: Colors.red,
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.discoverySettingAgeText,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              Text(
                '${(helpersFunctions.ageMinToShow as double).toStringAsFixed(0)} - '
                '${(helpersFunctions.ageMaxToShow as double).toStringAsFixed(0)}',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.red[400],
              inactiveTrackColor: Colors.grey,
              thumbColor: Colors.grey.shade100,
              overlayColor: Colors.red[400],
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 2),
            ),
            child: RangeSlider(
              values: RangeValues(
                  helpersFunctions.ageMinToShow, helpersFunctions.ageMaxToShow),
              divisions: ((70 - 18) ~/ 1),
              min: 18,
              max: 70,
              onChanged: (RangeValues values) {
                double start = values.start;
                double end = values.end;
                double distance = end - start;
                if (distance < 4) {
                  if (start == 18) {
                    end = start + 4;
                  } else {
                    start = end - 4;
                  }
                }
                setState(() {
                  helpersFunctions.ageMinToShow = start;
                  helpersFunctions.ageMaxToShow = end;
                });
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  S().discoverySettingShowOnly,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
              Expanded(
                flex: 1,
                child: CupertinoSwitch(
                  activeColor: Colors.red[400],
                  value: helpersFunctions.accessAge,
                  onChanged: (newValue) {
                    setState(() {
                      helpersFunctions.accessAge = newValue;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
