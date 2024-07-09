import 'package:chat_app/app/app_color.dart';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/ui/update_profile/widgets/height_bottom_sheet.dart';
import 'package:chat_app/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'update_profile_cubit.dart';
import 'update_profile_navigator.dart';
import 'widgets/basic_information_row.dart';
import 'widgets/dating_purpose_bottom_sheet.dart';
import 'widgets/gender_bottom_sheet.dart';
import 'widgets/interest_bottom_sheet.dart';
import 'widgets/language_bottom_sheet.dart';
import 'widgets/life_style_row.dart';
import 'widgets/update_image.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UpdateProfileCubit(
          navigator: UpdateProfileNavigator(context: context),
        );
      },
      child: UpdateProfileChildPage(
        user: user,
      ),
    );
  }
}

class UpdateProfileChildPage extends StatefulWidget {
  const UpdateProfileChildPage({super.key, required this.user});

  final UserEntity user;

  @override
  State<UpdateProfileChildPage> createState() => _UpdateProfileChildPageState();
}

class _UpdateProfileChildPageState extends State<UpdateProfileChildPage> {
  late final UpdateProfileCubit _cubit;
  final introduceController = TextEditingController();
  final companyController = TextEditingController();
  final schoolController = TextEditingController();
  AudioPlayer audioPlayer = AudioPlayer();
  // final currentAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData(widget.user);
    introduceController.text = _cubit.state.introduceYourself ?? "";
    companyController.text = _cubit.state.company ?? "";
    schoolController.text = _cubit.state.school ?? "";
    //  currentAddressController.text = _cubit.state.school ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _cubit.updateProfile(
          introduceYourself: introduceController.text,
          company: companyController.text,
          school: schoolController.text,
          //currentAddress: currentAddressController.text
        );
        return true;
      },
      child: Scaffold(
        appBar: PrimaryAppBar(
          context: context,
          text: S.current.updateProfileTitleAppbar,
        ),
        body: SafeArea(
          child: _buildBodyWidget(),
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
      builder: (context, state) {
        return Stack(
          children: [
            _buildMainContent(state),
            state.loadDataStatus == LoadStatus.loading
                ? _buildLoading()
                : const SizedBox(),
          ],
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  Widget _buildLoading() {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Stack(
        children: [
          // Nền mờs
          Opacity(
            opacity: 0.7,
            child: ModalBarrier(
              dismissible: false,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          // Loading Indicator
          Center(
            child: LoadingAnimationWidget.dotsTriangle(
              color: const Color(0xFFd73730),
              size: 70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(UpdateProfileState state) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.grey.shade200
            : AppColors.black700,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUpdatePhotos(),
            _buildUpdateIntroduce(),
            _buildUpdateHabits(),
            _buildUpdateDatingPurpose(),
            _buildUpdateHeight(),
            _buildUpdateLanguage(),
            _buildUpdateBasicInfo(),
            _buildUpdateLifeStyle(),
            _buildUpdateCompany(state.company ?? ''),
            _buildUpdateSchool(state.school ?? ''),
            _buildUpdateSpotify(),
            // _buildUpdateAddress(state.currentAddress ?? ''),
            _buildUpdateGender(),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdatePhotos() {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - 210) / 2;
    final double itemWidth = size.width / 2;
    return Column(
      children: [
        SectionTitle(title: S().updateProfilePhotosText),
        BlocProvider<UpdateProfileCubit>.value(
          value: _cubit,
          child: UpdateImage(
            itemWidth: itemWidth,
            itemHeight: itemHeight,
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateIntroduce() {
    return Column(
      children: [
        SectionTitle(
          title: S().updateProfileAboutMeText,
        ),
        Container(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          child: Column(
            children: [
              TextField(
                controller: introduceController,
                keyboardType: TextInputType.multiline,
                maxLength: 500,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                onChanged: (value) {},
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                  border: InputBorder.none,
                  hintText: S().updateProfileAboutMeText,
                ),
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateHabits() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
      ),
      child: Column(
        children: [
          SectionTitle(
            title: S().updateProfileHobbiesText,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: true,
                useSafeArea: true,
                context: context,
                builder: (context) {
                  return BlocProvider<UpdateProfileCubit>.value(
                      value: _cubit, child: const InterestBottomSheet());
                },
              ).whenComplete(() {});
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 16.0, top: 16.0, bottom: 16.0, right: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _cubit.state.interestsList!.isNotEmpty
                          ? HelpersDataUser.getItemFromListIndex(
                                  HelpersDataUser.interestsList(),
                                  _cubit.state.interestsList!)
                              .join(", ")
                          : S.current.emptyText,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade700,
                    size: 12,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateDatingPurpose() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
      ),
      child: Column(
        children: [
          SectionTitle(
            title: S().updateProfileDatingPurposeText,
          ),
          InkWell(
            splashColor: const Color.fromRGBO(229, 58, 69, 100),
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: true,
                useSafeArea: true,
                context: context,
                builder: (context) {
                  return BlocProvider<UpdateProfileCubit>.value(
                      value: _cubit, child: const DatingPurposeBottomSheet());
                },
              ).whenComplete(() {});
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 16.0, top: 16.0, bottom: 16.0, right: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.grey.shade700,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Image.asset(
                    HelpersDataUser
                        .emojiDatingPurposeList[_cubit.state.datingPurpose!],
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Expanded(
                    child: Text(
                      HelpersDataUser.getItemFromIndex(
                          HelpersDataUser.datingPurposeList(),
                          _cubit.state.datingPurpose!),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade700,
                    size: 12,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateHeight() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
      ),
      child: Column(
        children: [
          SectionTitle(
            title: S().updateProfileUserHeightTitle,
          ),
          InkWell(
            splashColor: const Color.fromRGBO(229, 58, 69, 100),
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: true,
                useSafeArea: true,
                context: context,
                builder: (context) {
                  return BlocProvider<UpdateProfileCubit>.value(
                      value: _cubit, child: const HeightBottomSheet());
                },
              ).whenComplete(() {});
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 16.0, top: 16.0, bottom: 16.0, right: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.height_rounded,
                    color: Colors.grey.shade700,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Text(
                      (_cubit.state.height ?? 0) > 0
                          ? '${_cubit.state.height} cm'
                          : S().updateProfileUserHeightHint,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade700,
                    size: 12,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateLanguage() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
      ),
      child: Column(
        children: [
          SectionTitle(
            title: S().updateProfileLanguagesIKnowText,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: true,
                useSafeArea: true,
                context: context,
                builder: (context) {
                  return BlocProvider.value(
                      value: _cubit, child: const LanguageBottomSheet());
                },
              ).whenComplete(() {});
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 16.0, top: 16.0, bottom: 16.0, right: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.g_translate,
                    color: Colors.grey.shade700,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Text(
                      (_cubit.state.fluentLanguageList ?? []).isNotEmpty
                          ? _cubit.state.fluentLanguageList!.join(', ')
                          : S().updateProfileLanguagesHintText,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade700,
                    size: 12,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateBasicInfo() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
      ),
      child: Column(
        children: [
          SectionTitle(
            title: S().updateProfileBasicInformationText,
          ),
          BasicInformationRow(
            cubit: _cubit,
            title: S().basicInformationZodiacText,
            content: _cubit.state.zodiac != null
                ? HelpersDataUser.getItemFromIndex(
                    HelpersDataUser.zodiacList(), _cubit.state.zodiac!)
                : S.current.emptyText,
            iconData: Icons.looks_rounded,
          ),
          BasicInformationRow(
            cubit: _cubit,
            title: S().basicInformationEducationText,
            content: _cubit.state.academicLever != null
                ? HelpersDataUser.getItemFromIndex(
                    HelpersDataUser.academicLeverList(),
                    _cubit.state.academicLever!)
                : S.current.emptyText,
            iconData: Icons.school_rounded,
          ),
          BasicInformationRow(
            cubit: _cubit,
            title: S().basicInformationFamilyText,
            content: _cubit.state.familyStyle != null
                ? HelpersDataUser.getItemFromIndex(
                    HelpersDataUser.familyStyleList(),
                    _cubit.state.familyStyle!)
                : S.current.emptyText,
            iconData: Icons.family_restroom_rounded,
          ),
          BasicInformationRow(
            cubit: _cubit,
            title: S().basicInformationPersonalityText,
            content: _cubit.state.personalityType ?? S.current.emptyText,
            iconData: Icons.personal_injury_rounded,
          ),
          BasicInformationRow(
            cubit: _cubit,
            title: S().basicInformationCommunicationText,
            content: _cubit.state.communicateStyle != null
                ? HelpersDataUser.getItemFromIndex(
                    HelpersDataUser.communicateStyleList(),
                    _cubit.state.communicateStyle!)
                : S.current.emptyText,
            iconData: Icons.comment_bank_rounded,
          ),
          BasicInformationRow(
            cubit: _cubit,
            title: S().basicInformationLoveText,
            content: _cubit.state.languageOfLove != null
                ? HelpersDataUser.getItemFromIndex(
                    HelpersDataUser.languageOfLoveList(),
                    _cubit.state.languageOfLove!)
                : S.current.emptyText,
            iconData: Icons.heart_broken_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateLifeStyle() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
      ),
      child: Column(
        children: [
          SectionTitle(
            title: S().updateProfileLifestyleText,
          ),
          LifeStyleRow(
            cubit: _cubit,
            title: S().lifestylePetText,
            content: _cubit.state.myPet != null
                ? HelpersDataUser.getItemFromIndex(
                    HelpersDataUser.myPetList(), _cubit.state.myPet!)
                : S.current.emptyText,
            iconData: Icons.pets_rounded,
          ),
          LifeStyleRow(
            cubit: _cubit,
            title: S().lifestyleAlcoholText,
            content: _cubit.state.drinkingStatus != null
                ? HelpersDataUser.getItemFromIndex(
                    HelpersDataUser.drinkingStatusList(),
                    _cubit.state.drinkingStatus!)
                : S.current.emptyText,
            iconData: Icons.wine_bar_rounded,
          ),
          LifeStyleRow(
            cubit: _cubit,
            title: S().lifestyleSmokeText,
            content: _cubit.state.smokingStatus != null
                ? HelpersDataUser.getItemFromIndex(
                    HelpersDataUser.smokingStatusList(),
                    _cubit.state.smokingStatus!)
                : S.current.emptyText,
            iconData: Icons.smoking_rooms_rounded,
          ),
          LifeStyleRow(
            cubit: _cubit,
            title: S().lifestyleExerciseText,
            content: _cubit.state.sportsStatus != null
                ? HelpersDataUser.getItemFromIndex(
                    HelpersDataUser.sportsStatusList(),
                    _cubit.state.sportsStatus!)
                : S.current.emptyText,
            iconData: Icons.fitness_center_rounded,
          ),
          LifeStyleRow(
            cubit: _cubit,
            title: S().lifestyleDietaryText,
            content: _cubit.state.eatingStatus != null
                ? HelpersDataUser.getItemFromIndex(
                    HelpersDataUser.eatingStatusList(),
                    _cubit.state.eatingStatus!)
                : S.current.emptyText,
            iconData: Icons.local_pizza_rounded,
          ),
          LifeStyleRow(
            cubit: _cubit,
            title: S().lifestyleMediaText,
            content: _cubit.state.socialNetworkStatus != null
                ? HelpersDataUser.getItemFromIndex(
                    HelpersDataUser.socialNetworkStatusList(),
                    _cubit.state.socialNetworkStatus!)
                : S.current.emptyText,
            iconData: Icons.social_distance_rounded,
          ),
          LifeStyleRow(
            cubit: _cubit,
            title: S().lifestyleSleepText,
            content: _cubit.state.sleepingHabits != null
                ? HelpersDataUser.getItemFromIndex(
                    HelpersDataUser.sleepingHabitsStatusList(),
                    _cubit.state.sleepingHabits!)
                : S.current.emptyText,
            iconData: Icons.wb_twighlight,
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateCompany(String s) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
      ),
      child: Column(
        children: [
          SectionTitle(
            title: S().updateProfileCompanyText,
          ),
          Container(
            padding: const EdgeInsets.only(right: 16.0, left: 16.0),
            child: TextField(
              controller: companyController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                border: InputBorder.none,
                hintText: S().updateProfileCompanyHintText,
              ),
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateSchool(String s) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
      ),
      child: Column(
        children: [
          SectionTitle(
            title: S().updateProfileSchoolText,
          ),
          Container(
            padding: const EdgeInsets.only(right: 16.0, left: 16.0),
            child: TextField(
              controller: schoolController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                border: InputBorder.none,
                hintText: S().updateProfileSchoolHintText,
              ),
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

/*
  Widget _buildUpdateAddress(String s) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
      ),
      child: Column(
        children: [
          SectionTitle(
            title: S().updateProfileLivingText,
          ),
          Container(
            padding: const EdgeInsets.only(right: 16.0, left: 16.0),
            child: TextField(
              enabled: false,
              controller: currentAddressController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                border: InputBorder.none,
                hintText: S().updateProfileLivingHintText,
              ),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
*/

  Widget _buildUpdateGender() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
      ),
      child: Column(
        children: [
          SectionTitle(
            title: S().updateProfileGenderText,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: true,
                useSafeArea: true,
                context: context,
                builder: (context) {
                  return BlocProvider<UpdateProfileCubit>.value(
                      value: _cubit, child: const GenderBottomSheet());
                },
              ).whenComplete(() {});
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(),
              child: Text(
                HelpersDataUser.getItemFromIndex(
                    HelpersDataUser.genderList(), _cubit.state.gender!),
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateSpotify() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
      ),
      child: Column(
        children: [
           SectionTitle(
            title: S().updateSpotifySelectTitle,
          ),
          InkWell(
            onTap: () async {
              Map<String, dynamic>? updatedSong =
                  await context.pushNamed(AppRoutes.chooseSpotifySong);
              if (updatedSong != null && updatedSong.isNotEmpty) {
                _cubit.updateState(_cubit.state.copyWith(
                    spotifyInformation: updatedSong['itemSpotify']));
              }
            },
            child: Ink(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  (_cubit.state.spotifyInformation?.name ?? '').isEmpty ? Expanded(
                    child: Text(S().spotifySelectTitle,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ) : Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              _cubit.state.spotifyInformation?.name ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 5.0),
                                  child: SvgPicture.asset(
                                    "spotify".withIcon(),
                                    width: 12.w,
                                    height: 12.h,
                                  ),
                                ),
                                Text(
                                  _cubit.state.spotifyInformation?.artist.join(', ') ?? '',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                                              ),
                          IconButton(
                              onPressed: () {
                                if (_cubit.state.spotifyInformation?.previewUrl == null) return;
                                if (audioPlayer.playing) {

                                  audioPlayer.stop();
                                } else {
                                  audioPlayer
                                      .setUrl(_cubit.state.spotifyInformation?.previewUrl ?? '');
                                  audioPlayer.play();
                                }
                                setState(() {});
                              },
                              icon: Icon(
                                audioPlayer.playing ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                size: 24,
                                color: Colors.green,
                              ))
                        ],
                      ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade200
          : AppColors.black700,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(
          top: 16.0, right: 16.0, left: 16.0, bottom: 6.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
      ),
    );
  }
}
