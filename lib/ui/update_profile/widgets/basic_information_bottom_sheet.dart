import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/ui/update_profile/update_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/generated/l10n.dart';

class BasicInformationBottomSheet extends StatefulWidget {
  const BasicInformationBottomSheet({super.key});

  @override
  State<BasicInformationBottomSheet> createState() =>
      _BasicInformationBottomSheetState();
}

class _BasicInformationBottomSheetState extends State<BasicInformationBottomSheet> {
  late UpdateProfileCubit _cubit;
  double positionedHeight = 400;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<UpdateProfileCubit>(context);
  }


  @override
  Widget build(BuildContext context) {

    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      builder: (context, state) => Stack(children: [
        GestureDetector(
          onVerticalDragUpdate: (details) {
            double delta = details.primaryDelta!;
            if (delta < 0) {
              setState(() {
                positionedHeight = MediaQuery.of(context).size.height / 1.2;
              });
            } else {
              setState(() {
                positionedHeight = 400;
              });
            }
          },

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            padding: const EdgeInsets.only(left: 15.0, right: 15.0,),
            height: positionedHeight,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
              ),
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
            ),

            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 25,bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () async {
                                await _cubit
                                    .getUserProfileFromRemote()
                                    .then((value) => Navigator.of(context).pop());
                              },
                              icon: const Icon(
                                Icons.clear,
                                size: 30,
                              )),
                          IconButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              await _cubit
                                  .updateProfile(
                                zodiac: state.zodiac,
                                academicLever: state.academicLever,
                                communicateStyle: state.communicateStyle,
                                languageOfLove: state.languageOfLove,
                                familyStyle: state.familyStyle,
                                personalityType: state.personalityType,
                              );
                            },
                            icon: const Icon(
                              Icons.check_rounded,
                              color: Color.fromRGBO(229, 58, 69, 1),
                              size: 30,
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          S().basicInformationDialogTitle,
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        S().basicInformationDialogContent,
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildZodiac(context),
                      _buildAcademicLevel(context),
                      _buildFamilyStyle(context),
                      _buildPersonalityType(context),
                      _buildCommunicateStyle(context),
                      _buildLanguageOfLove(context)
                    ],
                  ),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : Colors.black,
                        ),

                        child: const Icon(Icons.linear_scale, size: 35,))),

              ],
            ),
          ),
        ),
      ]),
    );
  }
  Widget _titleBasicBottom({required IconData icon, required String title}){
    return  Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
      ],
    );
  }

  Widget _buildZodiac(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleBasicBottom(icon:Icons.looks_rounded,title:  S().basicInformationDialogZodiac),

        const SizedBox(
          height: 16,
        ),

        Wrap(
          children: List.generate(
            HelpersDataUser.zodiacList().length,
            (index) {
              final item = HelpersDataUser.zodiacList()[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () async {
                    _cubit.updateState(_cubit.state.copyWith(zodiac: index));

                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: index == _cubit.state.zodiac ? 2 : 1,
                        color: index == _cubit.state.zodiac
                            ? const Color.fromRGBO(
                                234,
                                64,
                                128,
                                1,
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
                ),
              );
            },
          ),
        ),
        Divider(
          color: Colors.grey.shade700,
          height: 32,
        ),
      ],
    );
  }

  Widget _buildAcademicLevel(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleBasicBottom(icon: Icons.school_rounded,title:  S().basicInformationDialogEducation),

        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersDataUser.academicLeverList().length,
            (index) {
              final item =
                  HelpersDataUser.academicLeverList()[index];
              return InkWell(
                onTap: () {
                  _cubit
                      .updateState(_cubit.state.copyWith(academicLever: index));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: index == _cubit.state.academicLever ? 2 : 1,
                        color: index == _cubit.state.academicLever
                            ? const Color.fromRGBO(
                                234,
                                64,
                                128,
                                1,
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
                ),
              );
            },
          ),
        ),
        Divider(
          color: Colors.grey.shade700,
          height: 32,
        ),
      ],
    );
  }

  Widget _buildFamilyStyle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleBasicBottom(icon: Icons.family_restroom_rounded,title:  S().basicInformationDialogFamily),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersDataUser.familyStyleList().length,
            (index) {
              final item =
                  HelpersDataUser.familyStyleList()[index];
              return InkWell(
                onTap: () {
                  _cubit.updateState(_cubit.state.copyWith(familyStyle: index));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: index == _cubit.state.familyStyle ? 2 : 1,
                        color: index == _cubit.state.familyStyle
                            ? const Color.fromRGBO(
                                234,
                                64,
                                128,
                                1,
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
                ),
              );
            },
          ),
        ),
        Divider(
          color: Colors.grey.shade700,
          height: 32,
        ),
      ],
    );
  }

  Widget _buildPersonalityType(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleBasicBottom(icon: Icons.personal_injury_rounded,title:  S().basicInformationDialogPersonality),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(HelpersDataUser.personalityTypeList.length,
            (index) {
              final item = HelpersDataUser.personalityTypeList[index];
              return InkWell(
                onTap: () {
                  _cubit.updateState(
                      _cubit.state.copyWith(personalityType: item));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: item == _cubit.state.personalityType ? 2 : 1,
                        color: item ==  _cubit.state.personalityType
                            ? const Color.fromRGBO(
                                234,
                                64,
                                128,
                                1,
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
                ),
              );
            },
          ),
        ),
        Divider(
          color: Colors.grey.shade700,
          height: 32,
        ),
      ],
    );
  }

  Widget _buildCommunicateStyle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleBasicBottom(icon: Icons.comment_bank_rounded,title:  S().basicInformationCommunicationText),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersDataUser.communicateStyleList().length,
                (index) {
              final item = HelpersDataUser.communicateStyleList()[index];
              return InkWell(
                onTap: () {
                  _cubit.updateState(
                      _cubit.state.copyWith(communicateStyle: index));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: index == _cubit.state.communicateStyle ? 2 : 1,
                        color: index == _cubit.state.communicateStyle
                            ? const Color.fromRGBO(
                          234,
                          64,
                          128,
                          1,
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
                ),
              );
            },
          ),
        ),
        Divider(
          color: Colors.grey.shade700,
          height: 32,
        ),
      ],
    );
  }

  Widget _buildLanguageOfLove(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleBasicBottom(icon: Icons.heart_broken_rounded,title:  S().basicInformationDialogLove),

        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersDataUser.languageOfLoveList().length,
            (index) {
              final item =
                  HelpersDataUser.languageOfLoveList()[index];
              return InkWell(
                onTap: () {
                  _cubit.updateState(
                      _cubit.state.copyWith(languageOfLove: index));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: index == _cubit.state.languageOfLove ? 2 : 1,
                        color: index == _cubit.state.languageOfLove
                            ? const Color.fromRGBO(
                                234,
                                64,
                                128,
                                1,
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
                ),
              );
            },
          ),
        ),

      ],
    );
  }
}
