import 'dart:developer';

import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/ui/setting_query/widgets/custom_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../config/helpers/helpers_database.dart';
import '../../../generated/l10n.dart';
import '../setting_query_cubit.dart';

class AdvancedSearchWidget extends StatefulWidget {
  const AdvancedSearchWidget({
    super.key,
  });

  @override
  State<AdvancedSearchWidget> createState() => _AdvancedSearchWidgetPageState();
}

class _AdvancedSearchWidgetPageState extends State<AdvancedSearchWidget> {
  late final SettingQueryCubit _cubit;

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
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      child: Column(
        children: [
          BlocBuilder<SettingQueryCubit, SettingQueryState>(
            buildWhen: (previous, current) =>
                previous.maxPhoto != current.maxPhoto,
            builder: (context, state) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.current.highSearchContentImage,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    (helpersFunctions.maxPhoto as double).toStringAsFixed(0),
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  )
                ],
              );
            },
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
            child: BlocBuilder<SettingQueryCubit, SettingQueryState>(
              buildWhen: (previous, current) =>
                  previous.maxPhoto != current.maxPhoto,
              builder: (context, state) {
                return Slider(
                  value: helpersFunctions.maxPhoto,
                  max: 20,
                  min: 1,
                  divisions: 20,
                  onChanged: (value) {
                    _cubit.updateMaxPhoto(value);
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  S().highSearchTitleBio,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
              Expanded(
                flex: 1,
                child: CupertinoSwitch(
                  activeColor: Colors.red[400],
                  value: helpersFunctions.accessBio,
                  onChanged: (newValue) {
                    setState(() {
                      helpersFunctions.accessBio = newValue;
                    });
                  },
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
          ),
          BlocBuilder<SettingQueryCubit, SettingQueryState>(
            buildWhen: (previous, current) =>
                previous.interests != current.interests,
            builder: (context, state) {
              return CustomField(
                title: S().highSearchTitleInterests,
                iconData: Icons.interests,
                select: helpersFunctions.interests != -1 ?  HelpersDataUser.interestsList()[helpersFunctions.interests] : '',
                onTap: () {
                  show(listString: HelpersDataUser.interestsList(), value: helpersFunctions.interests, title: S().interestDialogTitle)
                      .then((value) {
                    _cubit.updateInterest(int.parse(value));
                  });
                }, onReset: () {
                  _cubit.updateInterest(-1);
                  },
              );
            },
          ),
          const Divider(
            thickness: 1,
          ),

          BlocBuilder<SettingQueryCubit, SettingQueryState>(
            buildWhen: (previous, current) => previous.zodiac != current.zodiac,
            builder: (context, state) {
              return CustomField(
                title: S().highSearchTitleZodiac,
                iconData: Icons.looks_rounded,
                select:helpersFunctions.zodiac != -1 ? HelpersDataUser.zodiacList()[helpersFunctions.zodiac] : '',
                onTap: () {
                  show(listString: HelpersDataUser.zodiacList(), value: helpersFunctions.zodiac,title: S().basicInformationZodiacText).then((value) {
                    _cubit.updateZodiac(int.parse(value));
                  } );
                }, onReset: () {
                _cubit.updateZodiac(-1);
              },
              );
            },
          ),
          const Divider(
            thickness: 1,
          ),
          BlocBuilder<SettingQueryCubit, SettingQueryState>(
            buildWhen: (previous, current) =>
                previous.education != current.education,
            builder: (context, state) {
              return CustomField(
                title: S().highSearchTitleEducation,
                iconData: Icons.school_rounded,
                select: helpersFunctions.education != -1 ? HelpersDataUser.academicLeverList()[helpersFunctions.education] : '',
                onTap: () {
                  show(listString: HelpersDataUser.academicLeverList(), value: helpersFunctions.education,title: S().basicInformationEducationText)
                      .then((value) {
                    _cubit.updateEdu(int.parse(value));
                  });
                }, onReset: () {   _cubit.updateEdu(-1); },
              );
            },
          ),
          const Divider(
            thickness: 1,
          ),
          BlocBuilder<SettingQueryCubit, SettingQueryState>(
            buildWhen: (previous, current) =>
                previous.futureFamily != current.futureFamily,
            builder: (context, state) {
              return CustomField(
                title: S().highSearchTitleFamily,
                iconData: Icons.family_restroom_rounded,
                select:helpersFunctions.futureFamily != -1 ?  HelpersDataUser.familyStyleList()[helpersFunctions.futureFamily] : '',
                onTap: () {
                  show(listString: HelpersDataUser.familyStyleList(), value: helpersFunctions.futureFamily,title: S().basicInformationFamilyText)
                      .then((value) {
                    _cubit.updateFamily(int.parse(value));
                  });
                }, onReset: () {  _cubit.updateFamily(-1); },
              );
            },
          ),
          const Divider(
            thickness: 1,
          ),
          BlocBuilder<SettingQueryCubit, SettingQueryState>(
            buildWhen: (previous, current) =>
                previous.personalityType != current.personalityType,
            builder: (context, state) {
              return CustomField(
                title: S().highSearchTitlePersonality,
                iconData: Icons.personal_injury_rounded,
                select:helpersFunctions.personType != -1 ? HelpersDataUser.personalityTypeList[helpersFunctions.personType]: '',
                onTap: () {
                  show(listString: HelpersDataUser.personalityTypeList, value: helpersFunctions.personType,title: S().basicInformationPersonalityText)
                      .then((value) {
                    _cubit.updatePerson(int.parse(value));
                  });
                }, onReset: () {  _cubit.updatePerson(-1); },
              );
            },
          ),
          const Divider(
            thickness: 1,
          ),
          BlocBuilder<SettingQueryCubit, SettingQueryState>(
            buildWhen: (previous, current) =>
                previous.communication != current.communication,
            builder: (context, state) {
              return CustomField(
                title: S().highSearchTitleCommunication,
                iconData: Icons.comment_bank_rounded,
                select:helpersFunctions.communicationStyle != -1 ? HelpersDataUser.communicateStyleList()[helpersFunctions.communicationStyle]: '',
                onTap: () {
                  show(listString: HelpersDataUser.communicateStyleList(), value: helpersFunctions.communicationStyle,title: S().basicInformationCommunicationText)
                      .then((value) {
                    _cubit.updateCommunication(int.parse(value));
                  });
                }, onReset: () {    _cubit.updateCommunication(-1); },
              );
            },
          ),
          const Divider(
            thickness: 1,
          ),
          BlocBuilder<SettingQueryCubit, SettingQueryState>(
            buildWhen: (previous, current) =>
                previous.loveLanguage != current.loveLanguage,
            builder: (context, state) {
              return CustomField(
                title: S().highSearchTitleLove,
                iconData: Icons.heart_broken_rounded,
                select:helpersFunctions.loveLanguage != -1 ? HelpersDataUser.languageOfLoveList()[
                    helpersFunctions.loveLanguage] : '',
                onTap: () {
                  show(listString: HelpersDataUser.languageOfLoveList(), value: helpersFunctions.loveLanguage,title: S().basicInformationLoveText)
                      .then((value) {
                    _cubit.updateLove(int.parse(value));
                  });
                }, onReset: () {     _cubit.updateLove(-1);},
              );
            },
          ),
          const Divider(
            thickness: 1,
          ),
          BlocBuilder<SettingQueryCubit, SettingQueryState>(
            buildWhen: (previous, current) => previous.pets != current.pets,
            builder: (context, state) {
              return CustomField(
                title: S().highSearchTitlePets,
                iconData: Icons.pets_rounded,
                select:helpersFunctions.pets != -1 ? HelpersDataUser.myPetList()[helpersFunctions.pets]: '',
                onTap: () {
                  show(listString: HelpersDataUser.myPetList(), value: helpersFunctions.pets,title: S().lifestylePetText).then((value) {
                    _cubit.updatePets(int.parse(value));
                  });
                }, onReset: () {   _cubit.updatePets(-1); },
              );
            },
          ),
          const Divider(
            thickness: 1,
          ),
          BlocBuilder<SettingQueryCubit, SettingQueryState>(
            buildWhen: (previous, current) =>
                previous.alcoholConsumption != current.alcoholConsumption,
            builder: (context, state) {
              return CustomField(
                title: S().highSearchTitleAlcohol,
                iconData: Icons.wine_bar_rounded,
                select: helpersFunctions.alcoholConsumption != -1 ? HelpersDataUser.drinkingStatusList()[
                    helpersFunctions.alcoholConsumption]: '',
                onTap: () {
                  show(listString: HelpersDataUser.drinkingStatusList(), value: helpersFunctions.alcoholConsumption,title: S().lifestyleAlcoholText)
                      .then((value) {
                    _cubit.updateAlcohol(int.parse(value));
                  });
                }, onReset: () {     _cubit.updateAlcohol(-1); },
              );
            },
          ),
          const Divider(
            thickness: 1,
          ),
          BlocBuilder<SettingQueryCubit, SettingQueryState>(
            buildWhen: (previous, current) => previous.smoke != current.smoke,
            builder: (context, state) {
              return CustomField(
                title: S().highSearchTitleSmoke,
                iconData: Icons.smoking_rooms_rounded,
                select:
                helpersFunctions.smoke != -1 ?  HelpersDataUser.smokingStatusList()[helpersFunctions.smoke] : '',
                onTap: () {
                  show(listString: HelpersDataUser.smokingStatusList(), value: helpersFunctions.smoke,title: S().lifestyleSmokeText)
                      .then((value) {
                    _cubit.updateSmoke(int.parse(value));
                  });
                }, onReset: () {   _cubit.updateSmoke(-1); },
              );
            },
          ),
          const Divider(
            thickness: 1,
          ),
          BlocBuilder<SettingQueryCubit, SettingQueryState>(
            buildWhen: (previous, current) =>
                previous.exercise != current.exercise,
            builder: (context, state) {
              return CustomField(
                title: S().highSearchTitleExercise,
                iconData: Icons.fitness_center_rounded,
                select:helpersFunctions.exercise != -1 ? HelpersDataUser.sportsStatusList()[
                    helpersFunctions.exercise] : '',
                onTap: () {
                  show(listString: HelpersDataUser.sportsStatusList(),value: helpersFunctions.exercise,title: S().lifestyleExerciseText)
                      .then((value) {
                    _cubit.updateExercise(int.parse(value));
                  });
                }, onReset: () {   _cubit.updateExercise(-1);  },
              );
            },
          ),
          const Divider(
            thickness: 1,
          ),
          BlocBuilder<SettingQueryCubit, SettingQueryState>(
            buildWhen: (previous, current) =>
                previous.dietary != current.dietary,
            builder: (context, state) {
              return CustomField(
                title: S().highSearchTitleDietary,
                iconData: Icons.local_pizza_rounded,
                select:helpersFunctions.dietaryHabit != -1 ? HelpersDataUser.eatingStatusList()[
                    helpersFunctions.dietaryHabit] : '',
                onTap: () {
                  show(listString: HelpersDataUser.eatingStatusList(), value: helpersFunctions.dietaryHabit,title: S().lifeStyleDialogEatText)
                      .then((value) {
                    _cubit.updateDietary(int.parse(value));
                  });
                },
                onReset: (){
                  _cubit.updateDietary(-1);
                },
              );
            },
          ),
          const Divider(
            thickness: 1,
          ),

          BlocBuilder<SettingQueryCubit, SettingQueryState>(
            buildWhen: (previous, current) => previous.sleep != current.sleep,
            builder: (context, state) {
              return CustomField(
                title: S().highSearchTitleSleep,
                iconData: Icons.wb_twighlight,
                select: helpersFunctions.sleepHabits != -1 ? HelpersDataUser.sleepingHabitsStatusList()[
                    helpersFunctions.sleepHabits] : '',
                onTap: () {
                  show(listString: HelpersDataUser.sleepingHabitsStatusList(), value: helpersFunctions.sleepHabits,title: S().lifestyleSleepText)
                      .then((value) {
                    _cubit.updateSleep(int.parse(value));
                  });
                }, onReset: () {   _cubit.updateSleep(-1);  },
              );
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> show({List<String>? listString, required int value, required String title}) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(top: 20.w, bottom: 30, left: 15, right: 8),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 25.sp),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Wrap(
                      children: List.generate(listString?.length ?? 0,
                        (index) {
                          final item = (listString ?? [])[index];
                          var isSelected = value != -1 ? HelpersDataUser.getItemFromIndex(listString ?? [], value)
                              .contains(item) : false;
                           return InkWell(
                              onTap: () {
                                  context.pop('$index');
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                margin:  EdgeInsets.only(right: 8, top: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    width: isSelected ? 2 : 1,
                                    color: isSelected ? const Color.fromRGBO(234, 64, 128, 1,
                                    )
                                        : Colors.grey,
                                  ),
                                ),
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
