import 'dart:math';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../model/package_binder_model.dart';
import '../../ui/widgets/popup_notification.dart';

class HelpersDataUser {
  static List<String> getItemFromListIndex(List<String> stringList, List<int> indexes) {
    List<String> list = [];
    for (int index in indexes) {
      if (index >= 0 && index < stringList.length) {
        list.add(stringList[index]);
      }
    }
    return list;
  }

  static String removeDecimalFromDouble(double value,
      {int fractionDigits = 0}) {
    return value.toStringAsFixed(fractionDigits);
  }

  static bool isStringContains(String input, String value) {
    if (input.contains(value)) {
      return true;
    }
    return false;
  }

  static String convertSeconds(int seconds) {
    int days = seconds ~/ (24 * 3600);
    seconds = seconds % (24 * 3600);
    int hours = seconds ~/ 3600;
    seconds %= 3600;
    int minutes = seconds ~/ 60;
    seconds %= 60;

    String result = '';
    if (days > 0) {
      result += '$days ${S().setting_time_day} ';
    }
    if (hours > 0) {
      result += '$hours ${S().setting_time_hour} ';
    }
    if (minutes > 0) {
      result += '$minutes ${S().setting_time_minute} ';
    }
    if (seconds > 0) {
      result += '$seconds ${S().setting_time_second} ';
    }

    return result.trim();
  }

  static String formatMillisecondsSinceEpoch(String millisecondsSinceEpoch) {
    final time = int.parse(millisecondsSinceEpoch);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    String formattedDateTime =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS").format(dateTime);
    return formattedDateTime;
  }

  static String formatMillisecondsSinceEpochToDateAndTime(
      String millisecondsSinceEpoch) {
    final time = int.parse(millisecondsSinceEpoch);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);
    String formattedDateTime = DateFormat("HH:mm dd/MM/yyyy").format(dateTime);
    return formattedDateTime;
  }

  static String strCalculateTimeDifference(int createAt) {
    DateTime createdAt = DateTime.fromMillisecondsSinceEpoch(createAt);
    DateTime currentTime = DateTime.now();

    Duration difference = currentTime.difference(createdAt);
    if (difference.inHours < 1) {
      int minutesDifference = difference.inMinutes;
      return '$minutesDifference ${S().selectionPageMinuteText}';
    } else if (difference.inHours <= 24) {
      int hoursDifference = difference.inHours;
      return '$hoursDifference ${S().selectionPageHourText}';
    } else {
      int daysDifference = difference.inDays;
      return '$daysDifference ${S().titleActive_Day}';
    }
  }

  static String strAcronymCalculateTimeDifference(int createAt) {
    DateTime createdAt = DateTime.fromMillisecondsSinceEpoch(createAt);
    DateTime currentTime = DateTime.now();

    Duration difference = currentTime.difference(createdAt);
    if (difference.inHours < 1) {
      int minutesDifference = difference.inMinutes;
      return '${minutesDifference == 0 ? 1 : minutesDifference}p';
    } else if (difference.inHours <= 24) {
      int hoursDifference = difference.inHours;
      return '${hoursDifference}h';
    } else {
      int daysDifference = difference.inDays;
      return '${daysDifference}d';
    }
  }

  static int calculateTimeDifference(int createAt) {
    DateTime createdAt = DateTime.fromMillisecondsSinceEpoch(createAt);
    DateTime currentTime = DateTime.now();

    Duration difference = currentTime.difference(createdAt);
    if (difference.inHours < 1) {
      int minutesDifference = difference.inMinutes;
      return minutesDifference;
    } else if (difference.inHours <= 24) {
      int hoursDifference = difference.inHours;
      return hoursDifference;
    } else {
      int daysDifference = difference.inDays;
      return daysDifference;
    }
  }




  static String formatBillDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  static List<int> findCommonValues(List<int> list1, List<int> list2) {
    Set<int> set1 = list1.toSet();
    Set<int> set2 = list2.toSet();

    Set<int> commonValues = set1.intersection(set2);

    return commonValues.toList();
  }
  static String formatCurrency(double amount) {
    int roundedAmount = amount.round();
    List<String> parts = roundedAmount.toString().split(".");
    String integerPart = parts[0];


    String formattedInteger = "";
    for (int i = integerPart.length - 1, count = 0; i >= 0; i--) {
      formattedInteger = integerPart[i] + formattedInteger;
      count++;
      if (count == 3 && i > 0) {
        formattedInteger = "." + formattedInteger;
        count = 0;
      }
    }

    return formattedInteger;
  }

  static String getPriceByPackage({required double price, required List<Package> listPackage }) {
    if(listPackage.isNotEmpty){
      if(price == 19){
        return listPackage[0].storeProduct.priceString.toString();
      }else if(price == 49){
        return listPackage[1].storeProduct.priceString.toString();
      }else {
        return listPackage[2].storeProduct.priceString.toString();
      }

    }
    return '';
  }

  static Package? getPackageByPrice({required double price, required List<Package> listPackage }) {
    if(listPackage.isNotEmpty){
      if(price == 19){
        return listPackage[0];
      }else if(price == 49){
        return listPackage[1];
      }else {
        return listPackage[2];
      }

    }
    return null;
  }


  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static String getItemFromIndex(List<String> stringList, int index) {
    if (index >= 0 && index < stringList.length) {
      return stringList[index];
    }
    return '';
  }

  static String processDateTime(String dateTimeStr) {
    DateTime currentDateTime = DateTime.now();
    try {
      DateTime inputDateTime =
          DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS").parse(dateTimeStr);
      Duration difference = currentDateTime.difference(inputDateTime);
      if (difference.inDays == 0) {
        return DateFormat("HH:mm:ss").format(inputDateTime); //
      } else if (difference.inDays == 1) {
        return S().yesterdayText;
      } else {
        return "${difference.inDays} ${S().yesterdayText_2}";
      }
    } catch (e) {
      return S().invalidDateAndTimeErrorText;
    }
  }

  static int calculateDistance(GeoPoint point1, GeoPoint point2) {
    const int radiusEarth = 6371;
    double lat1 = point1.latitude;
    double lon1 = point1.longitude;
    double lat2 = point2.latitude;
    double lon2 = point2.longitude;

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    double a = pow(sin(dLat / 2), 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * pow(sin(dLon / 2), 2);
    double c = 2 * asin(sqrt(a));
    double distance = radiusEarth * c;

    return distance.round();
  }

  static double _toRadians(double degree) {
    return degree * (pi / 180);
  }

  static bool isInteger(dynamic value) {
    if (value is int) {
      return true;
    } else if (value is String) {
      return int.tryParse(value) != null;
    } else {
      return false;
    }
  }

  static List<String> sexualOrientationList( ) {
    return [
      S().straight,
      S().gay,
      S().lesbian,
      S().bisexual,
      S().ansexual,
      S().demissexual,
      S().pansexual,
      S().transgender,
      S().uncertain
    ];
  }

  static List<String> datingPurposeList( ) {
    List<String> list = [
      S().lover,
      S().longTermDating,
      S().anything,
      S().casualRelationship,
      S().newFriends,
      S().notSureYet,
    ];
    return list;
  }

  static List<String> listInterests( ) {
    return [
      S().shopping,
      S().football,
      S().tableTennis,
      S().arteExhibitions,
      S().tikTok,
      S().eSports,
      S().parties,
      S().cosplay,
      S().cars,
      S().modernMusic,
      S().classicalMusic,
      S().fashion,
      S().motorcycles,
      S().selfCare,
      S().netflix,
      S().culinary,
      S().photography,
      S().archery,
      S().bubbleTea,
      S().sneakers,
      S().onlineGaming,
      S().wineAndBeer,
      S().cycling,
      S().karaoke,
      S().romanticMovies,
      S().horrorMovies,
      S().camping,
      S().surfing,
      S().writingBlogs,
      S().mountainClimbing,
      S().instagram,
      S().puzzles,
      S().literature,
      S().playingDrums,
      S().realEstate,
      S().entrepreneurship,
    ];
  }

  static List<String> emojiDatingPurposeList = [
    'emoji-love-arrow'.withIconPNG(),
    'emoji-in-love'.withIconPNG(),
    'emoji-party-popper'.withIconPNG(),
    'emoji-thinking'.withIconPNG(),
    'emoji-waving-hand'.withIconPNG(),
    'emoji-wine'.withIconPNG(),
  ];

  static List<String> emojiDialogMatch = [
    '👋',
    '😜',
    '❤️',
    '😍',
  ];

  static List<Color> colorBgPurposeList = [
    const Color.fromRGBO(255, 229, 236, 1.0),
    const Color.fromRGBO(255, 235, 235, 1.0),
    const Color.fromRGBO(241, 240, 215, 1.0),
    const Color.fromRGBO(228, 244, 220, 1.0),
    const Color.fromRGBO(217, 241, 221, 1.0),
    const Color.fromRGBO(223, 240, 244, 1.0),
  ];
  static List<Color> colorTitlePurposeList = [
    const Color.fromRGBO(229, 42, 121, 1.0),
    const Color.fromRGBO(193, 35, 35, 1.0),
    const Color.fromRGBO(188, 159, 30, 1.0),
    const Color.fromRGBO(47, 120, 10, 1.0),
    const Color.fromRGBO(26, 179, 52, 1.0),
    const Color.fromRGBO(10, 126, 155, 1.0),
  ];

  static List<String> zodiacList( ) {
    List<String> list = [
      S().capricorn,
      S().aquarius,
      S().pisces,
      S().aries,
      S().taurus,
      S().gemini,
      S().cancer,
      S().leo,
      S().virgo,
      S().libra,
      S().scorpio,
      S().sagittarius,
    ];
    return list;
  }

  static List<String> academicLeverList( ) {
    List<String> list = [
      S().bachelor,
      S().currentlyInCollege,
      S().highSchool,
      S().doctorate,
      S().postgraduateStudies,
      S().masterDegree,
      S().vocationalSchool,
    ];
    return list;
  }

  static List<String> personalityTypeList = [
    'INTJ',
    'INTP',
    'ENTJ',
    'ENTP',
    'INFJ',
    'INFP',
    'ENFJ',
    'ENFP',
    'ISTJ',
    'ESTJ',
    'ESFJ',
    'ISTP',
    'ISFP',
    'ESTP',
    'ESFP'
  ];

  static List<String> familyStyleList( ) {
    List<String> list = [
      S().familyStyle1,
      S().familyStyle2,
      S().familyStyle3,
      S().familyStyle4,
      S().familyStyle5
    ];
    return list;
  }

  static List<String> communicateStyleList( ) {
    List<String> list = [
      S().communicateStyle1,
      S().communicateStyle2,
      S().communicateStyle3,
      S().communicateStyle4,
      S().communicateStyle5
    ];
    return list;
  }

  static List<String> languageOfLoveList( ) {
    List<String> list = [
      S().languageOfLove1,
      S().languageOfLove2,
      S().languageOfLove3,
      S().languageOfLove4,
      S().languageOfLove5,
    ];
    return list;
  }

  static List<String> myPetList( ) {
    List<String> list = [
      S().dog,
      S().cat,
      S().reptile,
      S().amphibian,
      S().bird,
      S().fish,
      S().turtle,
      S().hamster,
      S().rabbit,
      S().likeButDontOwnPets,
      S().dontOwnPets,
      S().allTypesOfPets,
      S().interestedInOwningPet,
      S().allergicToAnimals
    ];
    return list;
  }

  static List<String> drinkingStatusList( ) {
    List<String> list = [
      S().drinkingStatus1,
      S().drinkingStatus2,
      S().drinkingStatus3,
      S().drinkingStatus4,
      S().drinkingStatus5,
      S().drinkingStatus6,
    ];
    return list;
  }

  static List<String> smokingStatusList( ) {
    List<String> list = [
      S().smokingStatus1,
      S().smokingStatus2,
      S().smokingStatus3,
      S().smokingStatus4,
      S().smokingStatus5
    ];
    return list;
  }

  static List<String> sportsStatusList( ) {
    List<String> list = [
      S().sportsStatus1,
      S().sportsStatus2,
      S().sportsStatus3,
      S().sportsStatus4
    ];
    return list;
  }

  static List<String> eatingStatusList( ) {
    List<String> list = [
      S().eatingStatus1,
      S().eatingStatus2,
      S().eatingStatus3,
      S().eatingStatus4,
      S().eatingStatus5,
      S().eatingStatus6,
      S().eatingStatus7
    ];
    return list;
  }

  static List<String> socialNetworkStatusList( ) {
    List<String> list = [
      S().socialNetworkStatus1,
      S().socialNetworkStatus2,
      S().socialNetworkStatus3,
      S().socialNetworkStatus4
    ];
    return list;
  }

  static List<String> sleepingHabitsStatusList( ) {
    List<String> list = [
      S().sleepingHabitsStatus1,
      S().sleepingHabitsStatus2,
      S().sleepingHabitsStatus3,
    ];
    return list;
  }

  static List<String> genderList( ) {
    return [
      S().genderSelect("male"),
      S().genderSelect("female"),
      S().genderSelect("other")
    ];
  }

  static List<String> requestToShowList( ) {
    return [
      S().genderSelectToShow('male'),
      S().genderSelectToShow("female"),
      S().genderSelectToShow("other")
    ];
  }

  static List<ThemeMode> listThemeMode() {
    List<ThemeMode> list = [
      ThemeMode.light,
      ThemeMode.dark
    ];
    return list;
  }
  static List<Brightness> listThemeBrightness() {
    List<Brightness> list = [
      Brightness.light,
      Brightness.dark,
    ];
    return list;
  }

  static List<String> listThemeModeTitle() {
    List<String> list = [
      S().settingThemeLight,
      S().settingThemeDark
    ];
    return list;
  }



  static List<String> highlightAppbarTitleList() {
    List<String> list = [
      '',
      S().highlightAppbarTitle1,
      S().highlightAppbarTitle2,
    ];
    return list;
  }

  static List<String> highlightPriceList = ['19', '49', '99'];

  static List<String> highlightTitleTimeList() {
    List<String> list = [
      S().highlightTime10,
      S().highlightTime20,
      S().highlightTime30,
    ];
    return list;
  }

  static List<int> highlightCountList = [5, 10, 15];

  static List<String> styleOfLifeUsers(UserEntity userModel) {
    List<String> list = [
      getItemFromIndex( myPetList(), userModel.myPet!),
      getItemFromIndex(drinkingStatusList(), userModel.drinkingStatus!),
      getItemFromIndex(smokingStatusList(), userModel.smokingStatus!),
      getItemFromIndex(sportsStatusList(), userModel.sportsStatus!),
      getItemFromIndex(eatingStatusList(), userModel.eatingStatus!),
      getItemFromIndex(socialNetworkStatusList(), userModel.socialNetworkStatus!),
      getItemFromIndex(sleepingHabitsStatusList(), userModel.sleepingHabits!),
    ];
    return list;
  }

  static List<IconData> styleOfLifeUsersIcon = [
    Icons.pets_rounded,
    Icons.wine_bar_rounded,
    Icons.smoking_rooms_rounded,
    Icons.fitness_center_rounded,
    Icons.local_pizza_rounded,
    Icons.social_distance_rounded,
    Icons.wb_twighlight,
  ];


  static List<String> basicInfoUsers(UserEntity userModel) {
    List<String> list = [
      getItemFromIndex( zodiacList(), userModel.zodiac!),
      getItemFromIndex(academicLeverList(), userModel.academicLever!),
      getItemFromIndex(languageOfLoveList(), userModel.languageOfLove!),
      getItemFromIndex(familyStyleList(), userModel.familyStyle!),
      getItemFromIndex(communicateStyleList(), userModel.communicateStyle!),

      userModel.personalityType.toString(),
    ];
    return list;
  }

  static List<IconData> basicInfoUsersIcon = [
    Icons.looks_rounded,
    Icons.school_rounded,
    Icons.heart_broken_rounded,
    Icons.family_restroom_rounded,
    Icons.comment_bank_rounded,
    Icons.personal_injury_rounded
  ];

  static bool isListNotEmpty(List<String> list) {
    return !list.every((element) => element == "");
  }

  static List<Map<String, dynamic>> countryCodes = [
    {'display': 'VN', 'value': '+84'},
    {'display': 'US', 'value': '+1'},
    {'display': 'UK', 'value': '+44'},
  ];
  static List<String> reportTitleList( ) {
    List<String> list = [
      S().reportReason_1,
      S().reportReason_2,
      S().reportReason_3,
    ];
    return list;
  }

  static List<String> reportTitleDetailList_1( ) {
    List<String> list = [
      S().reportDetailReason_1_1,
      S().reportDetailReason_1_2,
      S().reportDetailReason_1_3,
    ];
    return list;
  }
  static List<String> reportTitleDetailList_2( ) {
    List<String> list = [
      S().reportDetailReason_2_1,
      S().reportDetailReason_2_2,
    ];
    return list;
  }

  static bool isStringNotEmpty(String input) {
    if (input.isNotEmpty) {
      return true;
    }
    return false;
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    String pattern =
        r'^(0|84)(2(0[3-9]|1[0-6|8|9]|2[0-2|5-9]|3[2-9]|4[0-9]|5[1|2|4-9]|6[0-3|9]|7[0-7]|8[0-9]|9[0-4|6|7|9])|3[2-9]|5[5|6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])([0-9]{7})$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(phoneNumber);
  }

  static String isValidBirthday(String day, String month, String year) {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    if (day.isEmpty || month.isEmpty || year.isEmpty) {
      return 'Hãy nhập đủ ngày tháng năm sinh';
    } else if (int.parse(day) < 0 && int.parse(day) > 31) {
      return 'Ngày sinh đã vượt quá! Hãy nhập lại';
    } else if (int.parse(month) < 0 && int.parse(day) > 12) {
      return 'Tháng sinh đã vượt quá! Hãy nhập lại';
    } else if (int.parse(year) < 1900 && int.parse(year) > currentYear) {
      return 'Năm sinh đã vượt quá! Hãy nhập lại';
    }
    return 'Hãy nhập đủ dữ liệu.';
  }

  static String extractCity(String input, String separator, int indexFromEnd) {
    int lastIndex = input.lastIndexOf(separator);
    if (lastIndex != -1) {
      int startIndex = input.lastIndexOf(separator, lastIndex - 1);
      if (startIndex != -1) {
        startIndex += separator.length;
        if (startIndex < lastIndex) {
          String extractedSubstring =
              input.substring(startIndex, lastIndex).trim();
          return extractedSubstring;
        }
      }
    }
    return '';
  }

  static List<String> interestsList() {
    return [
      S().shopping,
      S().football,
      S().tableTennis,
      S().arteExhibitions,
      S().tikTok,
      S().eSports,
      S().parties,
      S().cosplay,
      S().cars,
      S().modernMusic,
      S().classicalMusic,
      S().fashion,
      S().motorcycles,
      S().selfCare,
      S().netflix,
      S().culinary,
      S().photography,
      S().archery,
      S().bubbleTea,
      S().sneakers,
      S().onlineGaming,
      S().wineAndBeer,
      S().cycling,
      S().karaoke,
      S().romanticMovies,
      S().horrorMovies,
      S().camping,
      S().surfing,
      S().writingBlogs,
      S().mountainClimbing,
      S().instagram,
    ];
  }

  static List<String> suggestedMessagesList() {
    return [
      S().suggestedMessage0,
      S().suggestedMessage1,
      S().suggestedMessage2,
      S().suggestedMessage3,
      S().suggestedMessage4,
      S().suggestedMessage5,
      S().suggestedMessage6,
    ];
  }

  static List<String> languageList() {
    return [
      'Vietnamese',
      'English',
      'Albanian',
      'Malay',
      'Pashto',
      'Portuguese',
      'Korean',
      'Armenian',
      'Japanese',
      'Kazakh',
      'Lao',
      'Mongolian',
      'Arabic',
      'Indonesian',
      'German',
      'Azerbaijani',
      'Arabic',
      'Russian',
      'Belarusian',
      'French',
      'Dzongkha',
      'Khmer',
      'Portuguese',
      'Sango',
      'Mandarin',
      'Malay',
      'Setswana',
      'Kikongo',
      'Lingala',
      'Spanish',
      'Turkish',
      'Tetum',
      'Italian',
      'Uzbek'
    ];
  }

  static List<String> listOnBoardingTitle() {
    return [
      S().titleOnBoarding1,
      S().titleOnBoarding2,
      S().titleOnBoarding3,
    ];
  }

  static List<String> listOnBoardingContent() {
    return [
      S().contentOnBoarding1,
      S().contentOnBoarding2,
      S().contentOnBoarding3,
    ];
  }

  static void packageVip({required int index, required BuildContext context}) {
    switch (index) {
      case 1:
        AppPopupNotification.showBottomModalVip(
          context: context,
          color: Colors.black54,
          title: "Finder",
          isHaveIcon: false,
          packageModel: packageBinderGoldList(context),
          assetsBanner: 'tinder-platinum-banner'.withIcon(),
          assetsIcon: 'ic_tinder_logo'.withImage(),
          isHaveColor: true,
          subTitle: S().sliderCustomSubTitle1,
        );
        break;
      case 2:
        AppPopupNotification.showBottomModalVip(
          context: context,
          color: const Color.fromRGBO(255, 216, 0, 1.0),
          title: "Finder",
          isHaveIcon: false,
          packageModel: packageBinderGoldList(context),
          assetsBanner: 'tinder-gold-banner'.withIcon(),
          assetsIcon: 'ic_tinder_logo'.withImage(),
          isHaveColor: true,
          subTitle: S().sliderCustomSubTitle2,
        );
        break;
      case 3:
        AppPopupNotification.showBottomModalVip(
          context: context,
          color: Colors.red,
          title: "Finder",
          isHaveIcon: false,
          packageModel: packageBinderGoldList(context),
          assetsBanner: 'tinder-plus-banner'.withIcon(),
          assetsIcon: 'ic_tinder_logo'.withImage(),
          isHaveColor: true,
          subTitle: S().sliderCustomSubTitle3,
        );
        break;
    }
  }

  static List<PackageModel> packageBinderPlatinumList(BuildContext context) {
    return [
      PackageModel(
        id: 1,
        title: '',
        name: '1 ${S().pageFunctionVipMonthText}',
        price: '279.000 ₫/${S().pageFunctionVipMonthText}',
        discount: 0,
      ),
      PackageModel(
        id: 2,
        title: S().pageFunctionVipPopularText,
        name: '6 ${S().pageFunctionVipMonthText}',
        price: '139.833 ₫/${S().pageFunctionVipMonthText}',
        discount: 50,
      ),
      PackageModel(
        id: 3,
        title: S().pageFunctionVipBestText,
        name: '12 ${S().pageFunctionVipMonthText}',
        price: '96.583 ₫/${S().pageFunctionVipMonthText}',
        discount: 65,
      ),
    ];
  }

  static List<PackageModel> packageBinderGoldList(BuildContext context) {
    return [
      PackageModel(
        id: 1,
        title: '',
        name: '1 ${S().pageFunctionVipMonthText}',
        price: '15 USD/${S().pageFunctionVipMonthText}',
        discount: 0,
      ),
      PackageModel(
        id: 2,
        title: S().pageFunctionVipPopularText,
        name: '6 ${S().pageFunctionVipMonthText}',
        price: '10 USD/${S().pageFunctionVipMonthText}',
        discount: 50,
      ),
      PackageModel(
        id: 3,
        title: S().pageFunctionVipBestText,
        name: '12 ${S().pageFunctionVipMonthText}',
        price: '5 USD/${S().pageFunctionVipMonthText}',
        discount: 65,
      ),
    ];
  }

  static List<PackageModel> packageBinderSuperLike(BuildContext context) {
    return [
      PackageModel(
        id: 1,
        title: '',
        name: '5 ${S().pageFunctionVipSuperText}',
        price: '39.800 ₫/${S().pageFunctionVipMonthText}',
        discount: 0,
      ),
      PackageModel(
        id: 2,
        title: S().pageFunctionVipPopularText,
        name: '25 ${S().pageFunctionVipSuperText}',
        price: '31.160 ₫/${S().pageFunctionVipMonthText}',
        discount: 22,
      ),
      PackageModel(
        id: 3,
        title: S().pageFunctionVipBestText,
        name: '60 ${S().pageFunctionVipSuperText}',
        price: '24.983 ₫/${S().pageFunctionVipMonthText}',
        discount: 37,
      ),
    ];
  }
}
