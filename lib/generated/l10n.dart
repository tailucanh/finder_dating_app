// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Start "Match and Chat"!`
  String get titleButtonOnBoarding {
    return Intl.message(
      'Start "Match and Chat"!',
      name: 'titleButtonOnBoarding',
      desc: '',
      args: [],
    );
  }

  /// `Algorithm`
  String get titleOnBoarding1 {
    return Intl.message(
      'Algorithm',
      name: 'titleOnBoarding1',
      desc: '',
      args: [],
    );
  }

  /// `Users going through a vetting process to ensure you never match with bots.`
  String get contentOnBoarding1 {
    return Intl.message(
      'Users going through a vetting process to ensure you never match with bots.',
      name: 'contentOnBoarding1',
      desc: '',
      args: [],
    );
  }

  /// `Matches`
  String get titleOnBoarding2 {
    return Intl.message(
      'Matches',
      name: 'titleOnBoarding2',
      desc: '',
      args: [],
    );
  }

  /// `We match you with people that have a large array of similar interests.`
  String get contentOnBoarding2 {
    return Intl.message(
      'We match you with people that have a large array of similar interests.',
      name: 'contentOnBoarding2',
      desc: '',
      args: [],
    );
  }

  /// `Premium`
  String get titleOnBoarding3 {
    return Intl.message(
      'Premium',
      name: 'titleOnBoarding3',
      desc: '',
      args: [],
    );
  }

  /// `Sign up today and enjoy the first month of premium benefits on us.`
  String get contentOnBoarding3 {
    return Intl.message(
      'Sign up today and enjoy the first month of premium benefits on us.',
      name: 'contentOnBoarding3',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get textOnBoarding1 {
    return Intl.message(
      'Already have an account?',
      name: 'textOnBoarding1',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get textOnBoarding2 {
    return Intl.message(
      'Sign In',
      name: 'textOnBoarding2',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get titleGoogleSignInButton {
    return Intl.message(
      'Sign in with Google',
      name: 'titleGoogleSignInButton',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Phone number`
  String get titlePhoneNumberSignInButton {
    return Intl.message(
      'Sign in with Phone number',
      name: 'titlePhoneNumberSignInButton',
      desc: '',
      args: [],
    );
  }

  /// `When you click Sign in, you agree to our `
  String get contentLogin1 {
    return Intl.message(
      'When you click Sign in, you agree to our ',
      name: 'contentLogin1',
      desc: '',
      args: [],
    );
  }

  /// `Terms`
  String get contentLogin2 {
    return Intl.message(
      'Terms',
      name: 'contentLogin2',
      desc: '',
      args: [],
    );
  }

  /// `. Learn more about how we handle your data in our `
  String get contentLogin3 {
    return Intl.message(
      '. Learn more about how we handle your data in our ',
      name: 'contentLogin3',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get contentLogin4 {
    return Intl.message(
      'Privacy Policy',
      name: 'contentLogin4',
      desc: '',
      args: [],
    );
  }

  /// `My phone number is `
  String get titleEnterPhoneNumber {
    return Intl.message(
      'My phone number is ',
      name: 'titleEnterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get hintTextPhone {
    return Intl.message(
      'Enter your phone number',
      name: 'hintTextPhone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get textErrorEnterPhone {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'textErrorEnterPhone',
      desc: '',
      args: [],
    );
  }

  /// `When you click Continue, Finder will send you a message containing a verification code. Standard messaging and data rates may apply. The verified phone number will be used for logging in. `
  String get contentNotificationPhoneLogin1 {
    return Intl.message(
      'When you click Continue, Finder will send you a message containing a verification code. Standard messaging and data rates may apply. The verified phone number will be used for logging in. ',
      name: 'contentNotificationPhoneLogin1',
      desc: '',
      args: [],
    );
  }

  /// `Learn what happens when your phone number changes.`
  String get contentNotificationPhoneLogin2 {
    return Intl.message(
      'Learn what happens when your phone number changes.',
      name: 'contentNotificationPhoneLogin2',
      desc: '',
      args: [],
    );
  }

  /// `My code is`
  String get titleEnterOTP {
    return Intl.message(
      'My code is',
      name: 'titleEnterOTP',
      desc: '',
      args: [],
    );
  }

  /// `The code you entered is invalid. Please try again.`
  String get textErrorOTP {
    return Intl.message(
      'The code you entered is invalid. Please try again.',
      name: 'textErrorOTP',
      desc: '',
      args: [],
    );
  }

  /// `Resend the code`
  String get textResendOTP {
    return Intl.message(
      'Resend the code',
      name: 'textResendOTP',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get textButtonResendOTP {
    return Intl.message(
      'Resend',
      name: 'textButtonResendOTP',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Finder`
  String get titleRulersPage {
    return Intl.message(
      'Welcome to Finder',
      name: 'titleRulersPage',
      desc: '',
      args: [],
    );
  }

  /// `Please adhere to these general rules.`
  String get contentRules {
    return Intl.message(
      'Please adhere to these general rules.',
      name: 'contentRules',
      desc: '',
      args: [],
    );
  }

  /// `Be yourself.`
  String get contentRule1 {
    return Intl.message(
      'Be yourself.',
      name: 'contentRule1',
      desc: '',
      args: [],
    );
  }

  /// `Ensure your photos, age, and biography are all genuine.`
  String get contentRule1_1 {
    return Intl.message(
      'Ensure your photos, age, and biography are all genuine.',
      name: 'contentRule1_1',
      desc: '',
      args: [],
    );
  }

  /// `Prioritize safety.`
  String get contentRule2 {
    return Intl.message(
      'Prioritize safety.',
      name: 'contentRule2',
      desc: '',
      args: [],
    );
  }

  /// `Avoid hastily sharing personal information. `
  String get contentRule2_1 {
    return Intl.message(
      'Avoid hastily sharing personal information. ',
      name: 'contentRule2_1',
      desc: '',
      args: [],
    );
  }

  /// ` Practice safe dating.`
  String get contentRule2_2 {
    return Intl.message(
      ' Practice safe dating.',
      name: 'contentRule2_2',
      desc: '',
      args: [],
    );
  }

  /// `Behave respectfully.`
  String get contentRule3 {
    return Intl.message(
      'Behave respectfully.',
      name: 'contentRule3',
      desc: '',
      args: [],
    );
  }

  /// `Respect others and treat them the way you want to be treated.`
  String get contentRule3_1 {
    return Intl.message(
      'Respect others and treat them the way you want to be treated.',
      name: 'contentRule3_1',
      desc: '',
      args: [],
    );
  }

  /// `Stay proactive.`
  String get contentRule4 {
    return Intl.message(
      'Stay proactive.',
      name: 'contentRule4',
      desc: '',
      args: [],
    );
  }

  /// `Always report any inappropriate behavior.`
  String get contentRule4_1 {
    return Intl.message(
      'Always report any inappropriate behavior.',
      name: 'contentRule4_1',
      desc: '',
      args: [],
    );
  }

  /// `What is your name ?`
  String get titleAddNamePage {
    return Intl.message(
      'What is your name ?',
      name: 'titleAddNamePage',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get textHintEnterName {
    return Intl.message(
      'Enter your name',
      name: 'textHintEnterName',
      desc: '',
      args: [],
    );
  }

  /// `This will be the content displayed on your profile. Please enter your actual name.`
  String get textNotificationNamePage {
    return Intl.message(
      'This will be the content displayed on your profile. Please enter your actual name.',
      name: 'textNotificationNamePage',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get gender_male {
    return Intl.message(
      'Male',
      name: 'gender_male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get gender_female {
    return Intl.message(
      'Female',
      name: 'gender_female',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get gender_other {
    return Intl.message(
      'Other',
      name: 'gender_other',
      desc: '',
      args: [],
    );
  }

  /// `Terms of use`
  String get terms_of_use {
    return Intl.message(
      'Terms of use',
      name: 'terms_of_use',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Sign up to continue`
  String get sign_up_to_continue {
    return Intl.message(
      'Sign up to continue',
      name: 'sign_up_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `Continue with email`
  String get continue_with_email {
    return Intl.message(
      'Continue with email',
      name: 'continue_with_email',
      desc: '',
      args: [],
    );
  }

  /// `or sign up with`
  String get or_sign_up_with {
    return Intl.message(
      'or sign up with',
      name: 'or_sign_up_with',
      desc: '',
      args: [],
    );
  }

  /// `Use phone number`
  String get use_phone_number {
    return Intl.message(
      'Use phone number',
      name: 'use_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `What is your date of birth?`
  String get titleAddBirthDayPage {
    return Intl.message(
      'What is your date of birth?',
      name: 'titleAddBirthDayPage',
      desc: '',
      args: [],
    );
  }

  /// `Choose the day you first appeared in this beautiful world?`
  String get contentAddBirthDayPage {
    return Intl.message(
      'Choose the day you first appeared in this beautiful world?',
      name: 'contentAddBirthDayPage',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid date of birth.`
  String get textErrorEnterBirthDay {
    return Intl.message(
      'Please enter a valid date of birth.',
      name: 'textErrorEnterBirthDay',
      desc: '',
      args: [],
    );
  }

  /// `Your profile will display your age information, not your date of birth.`
  String get textNotificationBirthDayPage {
    return Intl.message(
      'Your profile will display your age information, not your date of birth.',
      name: 'textNotificationBirthDayPage',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get textSelectDateDialog {
    return Intl.message(
      'Save',
      name: 'textSelectDateDialog',
      desc: '',
      args: [],
    );
  }

  /// `Wow, something's wrong!`
  String get titleNoInternet {
    return Intl.message(
      'Wow, something\'s wrong!',
      name: 'titleNoInternet',
      desc: '',
      args: [],
    );
  }

  /// `Please check your network connection and try again.`
  String get contentNoInternet {
    return Intl.message(
      'Please check your network connection and try again.',
      name: 'contentNoInternet',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get textButtonRetryInternet {
    return Intl.message(
      'Retry',
      name: 'textButtonRetryInternet',
      desc: '',
      args: [],
    );
  }

  /// `What is your gender ?`
  String get titleAddGender {
    return Intl.message(
      'What is your gender ?',
      name: 'titleAddGender',
      desc: '',
      args: [],
    );
  }

  /// `{gender, select, male{Male} female{Female} other{Other}}`
  String genderSelect(String gender) {
    return Intl.gender(
      gender,
      male: 'Male',
      female: 'Female',
      other: 'Other',
      name: 'genderSelect',
      desc: 'A gendered message',
      args: [gender],
    );
  }

  /// `You want to meet?`
  String get titleAddRequestToShow {
    return Intl.message(
      'You want to meet?',
      name: 'titleAddRequestToShow',
      desc: '',
      args: [],
    );
  }

  /// `{gender, select, male{Male} female{Female} other{Other}}`
  String genderSelectToShow(String gender) {
    return Intl.gender(
      gender,
      male: 'Male',
      female: 'Female',
      other: 'Other',
      name: 'genderSelectToShow',
      desc: 'A gendered message',
      args: [gender],
    );
  }

  /// `Search friend’s`
  String get textSearchFriends1 {
    return Intl.message(
      'Search friend’s',
      name: 'textSearchFriends1',
      desc: '',
      args: [],
    );
  }

  /// `You can find friends from your contact lists to connected`
  String get textSearchFriends2 {
    return Intl.message(
      'You can find friends from your contact lists to connected',
      name: 'textSearchFriends2',
      desc: '',
      args: [],
    );
  }

  /// `Oh no! It's a shame that there isn't an audience that matches your criteria. You can change the criteria and come back!`
  String get listCardEmptyContent {
    return Intl.message(
      'Oh no! It\'s a shame that there isn\'t an audience that matches your criteria. You can change the criteria and come back!',
      name: 'listCardEmptyContent',
      desc: '',
      args: [],
    );
  }

  /// `Access to a contact list`
  String get buttonSearchFriends {
    return Intl.message(
      'Access to a contact list',
      name: 'buttonSearchFriends',
      desc: '',
      args: [],
    );
  }

  /// `Enable notification’s`
  String get textNotification1 {
    return Intl.message(
      'Enable notification’s',
      name: 'textNotification1',
      desc: '',
      args: [],
    );
  }

  /// `Get push-notification when you get the match or receive a message.`
  String get textNotification2 {
    return Intl.message(
      'Get push-notification when you get the match or receive a message.',
      name: 'textNotification2',
      desc: '',
      args: [],
    );
  }

  /// `I want to be notified`
  String get buttonNotification {
    return Intl.message(
      'I want to be notified',
      name: 'buttonNotification',
      desc: '',
      args: [],
    );
  }

  /// `Stand out`
  String get highlightPageTitle {
    return Intl.message(
      'Stand out',
      name: 'highlightPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Promote your profile to increase compatibility with potential matches!`
  String get highlightPageContent {
    return Intl.message(
      'Promote your profile to increase compatibility with potential matches!',
      name: 'highlightPageContent',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get highlightAppbarTitle1 {
    return Intl.message(
      'Popular',
      name: 'highlightAppbarTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get highlightAppbarTitle2 {
    return Intl.message(
      'Popular',
      name: 'highlightAppbarTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get highlightTime10 {
    return Intl.message(
      'Popular',
      name: 'highlightTime10',
      desc: '',
      args: [],
    );
  }

  /// `Boost for 20 minutes`
  String get highlightTime20 {
    return Intl.message(
      'Boost for 20 minutes',
      name: 'highlightTime20',
      desc: '',
      args: [],
    );
  }

  /// `Boost for 30 minutes`
  String get highlightTime30 {
    return Intl.message(
      'Boost for 30 minutes',
      name: 'highlightTime30',
      desc: '',
      args: [],
    );
  }

  /// `usd/rate`
  String get highlightTimeRate {
    return Intl.message(
      'usd/rate',
      name: 'highlightTimeRate',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get highlightButtonText {
    return Intl.message(
      'Select',
      name: 'highlightButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Highlight completed. Hope you find your perfect match soon!`
  String get highlightNotificationText {
    return Intl.message(
      'Highlight completed. Hope you find your perfect match soon!',
      name: 'highlightNotificationText',
      desc: '',
      args: [],
    );
  }

  /// `I understand`
  String get highlightConfirmButton {
    return Intl.message(
      'I understand',
      name: 'highlightConfirmButton',
      desc: '',
      args: [],
    );
  }

  /// `Set Search Preferences`
  String get discoverySettingTitleAppbar {
    return Intl.message(
      'Set Search Preferences',
      name: 'discoverySettingTitleAppbar',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get discoverySettingConfirmText {
    return Intl.message(
      'Done',
      name: 'discoverySettingConfirmText',
      desc: '',
      args: [],
    );
  }

  /// `Priority distance`
  String get discoverySettingPriorityText {
    return Intl.message(
      'Priority distance',
      name: 'discoverySettingPriorityText',
      desc: '',
      args: [],
    );
  }

  /// `Show me`
  String get discoverySettingShowMeText {
    return Intl.message(
      'Show me',
      name: 'discoverySettingShowMeText',
      desc: '',
      args: [],
    );
  }

  /// `Preferred age`
  String get discoverySettingAgeText {
    return Intl.message(
      'Preferred age',
      name: 'discoverySettingAgeText',
      desc: '',
      args: [],
    );
  }

  /// `Show only people within this range`
  String get discoverySettingShowOnly {
    return Intl.message(
      'Show only people within this range',
      name: 'discoverySettingShowOnly',
      desc: '',
      args: [],
    );
  }

  /// `Show me`
  String get showMeTitleAppbar {
    return Intl.message(
      'Show me',
      name: 'showMeTitleAppbar',
      desc: '',
      args: [],
    );
  }

  /// `Finder welcomes everyone`
  String get showMeHello {
    return Intl.message(
      'Finder welcomes everyone',
      name: 'showMeHello',
      desc: '',
      args: [],
    );
  }

  /// `The Search Preferences section now displays users with more information about their `
  String get showMeContent1 {
    return Intl.message(
      'The Search Preferences section now displays users with more information about their ',
      name: 'showMeContent1',
      desc: '',
      args: [],
    );
  }

  /// `gender identity`
  String get showMeContent2 {
    return Intl.message(
      'gender identity',
      name: 'showMeContent2',
      desc: '',
      args: [],
    );
  }

  /// ` and `
  String get showMeContent3 {
    return Intl.message(
      ' and ',
      name: 'showMeContent3',
      desc: '',
      args: [],
    );
  }

  /// `sexual orientation.`
  String get showMeContent4 {
    return Intl.message(
      'sexual orientation.',
      name: 'showMeContent4',
      desc: '',
      args: [],
    );
  }

  /// `When users add more details about themselves, they can choose which search criteria best reflect their identity`
  String get showMeContent5 {
    return Intl.message(
      'When users add more details about themselves, they can choose which search criteria best reflect their identity',
      name: 'showMeContent5',
      desc: '',
      args: [],
    );
  }

  /// `Living in`
  String get livingIn {
    return Intl.message(
      'Living in',
      name: 'livingIn',
      desc: '',
      args: [],
    );
  }

  /// `Away`
  String get away {
    return Intl.message(
      'Away',
      name: 'away',
      desc: '',
      args: [],
    );
  }

  /// `Around here`
  String get around {
    return Intl.message(
      'Around here',
      name: 'around',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Please select an address`
  String get textValueAddress {
    return Intl.message(
      'Please select an address',
      name: 'textValueAddress',
      desc: '',
      args: [],
    );
  }

  /// `Say something interesting`
  String get hintTextDialogMatch {
    return Intl.message(
      'Say something interesting',
      name: 'hintTextDialogMatch',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get sendTextDialogMatch {
    return Intl.message(
      'Send',
      name: 'sendTextDialogMatch',
      desc: '',
      args: [],
    );
  }

  /// `View more profiles that match your criteria with Finder Gold™`
  String get highSearchSubTitle {
    return Intl.message(
      'View more profiles that match your criteria with Finder Gold™',
      name: 'highSearchSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `ADVANCED SEARCH`
  String get highSearchTitlePage {
    return Intl.message(
      'ADVANCED SEARCH',
      name: 'highSearchTitlePage',
      desc: '',
      args: [],
    );
  }

  /// `The criteria options help display people who match your preferences, but they won't limit you from seeing others - you can still match with people outside of your criteria choices.`
  String get highSearchContent {
    return Intl.message(
      'The criteria options help display people who match your preferences, but they won\'t limit you from seeing others - you can still match with people outside of your criteria choices.',
      name: 'highSearchContent',
      desc: '',
      args: [],
    );
  }

  /// `Minimum Number of Photos`
  String get highSearchContentImage {
    return Intl.message(
      'Minimum Number of Photos',
      name: 'highSearchContentImage',
      desc: '',
      args: [],
    );
  }

  /// `Do you have a bio?`
  String get highSearchTitleBio {
    return Intl.message(
      'Do you have a bio?',
      name: 'highSearchTitleBio',
      desc: '',
      args: [],
    );
  }

  /// `Interests`
  String get highSearchTitleInterests {
    return Intl.message(
      'Interests',
      name: 'highSearchTitleInterests',
      desc: '',
      args: [],
    );
  }

  /// `I'm looking for`
  String get highSearchTitleLookingFor {
    return Intl.message(
      'I\'m looking for',
      name: 'highSearchTitleLookingFor',
      desc: '',
      args: [],
    );
  }

  /// `Zodiac`
  String get highSearchTitleZodiac {
    return Intl.message(
      'Zodiac',
      name: 'highSearchTitleZodiac',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get highSearchTitleEducation {
    return Intl.message(
      'Education',
      name: 'highSearchTitleEducation',
      desc: '',
      args: [],
    );
  }

  /// `Future family`
  String get highSearchTitleFamily {
    return Intl.message(
      'Future family',
      name: 'highSearchTitleFamily',
      desc: '',
      args: [],
    );
  }

  /// `Personality type`
  String get highSearchTitlePersonality {
    return Intl.message(
      'Personality type',
      name: 'highSearchTitlePersonality',
      desc: '',
      args: [],
    );
  }

  /// `Communication style`
  String get highSearchTitleCommunication {
    return Intl.message(
      'Communication style',
      name: 'highSearchTitleCommunication',
      desc: '',
      args: [],
    );
  }

  /// `Love language`
  String get highSearchTitleLove {
    return Intl.message(
      'Love language',
      name: 'highSearchTitleLove',
      desc: '',
      args: [],
    );
  }

  /// `Pets`
  String get highSearchTitlePets {
    return Intl.message(
      'Pets',
      name: 'highSearchTitlePets',
      desc: '',
      args: [],
    );
  }

  /// `Alcohol consumption`
  String get highSearchTitleAlcohol {
    return Intl.message(
      'Alcohol consumption',
      name: 'highSearchTitleAlcohol',
      desc: '',
      args: [],
    );
  }

  /// `Do you smoke?`
  String get highSearchTitleSmoke {
    return Intl.message(
      'Do you smoke?',
      name: 'highSearchTitleSmoke',
      desc: '',
      args: [],
    );
  }

  /// `Exercise`
  String get highSearchTitleExercise {
    return Intl.message(
      'Exercise',
      name: 'highSearchTitleExercise',
      desc: '',
      args: [],
    );
  }

  /// `Dietary habits`
  String get highSearchTitleDietary {
    return Intl.message(
      'Dietary habits',
      name: 'highSearchTitleDietary',
      desc: '',
      args: [],
    );
  }

  /// `Social media`
  String get highSearchTitleSocial {
    return Intl.message(
      'Social media',
      name: 'highSearchTitleSocial',
      desc: '',
      args: [],
    );
  }

  /// `Sleep habits`
  String get highSearchTitleSleep {
    return Intl.message(
      'Sleep habits',
      name: 'highSearchTitleSleep',
      desc: '',
      args: [],
    );
  }

  /// `Swipe through the most attractive profiles every day.`
  String get selectionPageSubTitle {
    return Intl.message(
      'Swipe through the most attractive profiles every day.',
      name: 'selectionPageSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Top Picks`
  String get selectionPageTitleBar1 {
    return Intl.message(
      'Top Picks',
      name: 'selectionPageTitleBar1',
      desc: '',
      args: [],
    );
  }

  /// `Like`
  String get selectionPageTitleBar2 {
    return Intl.message(
      'Like',
      name: 'selectionPageTitleBar2',
      desc: '',
      args: [],
    );
  }

  /// `Recent Activity`
  String get selectionPageTitle {
    return Intl.message(
      'Recent Activity',
      name: 'selectionPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Everyone`
  String get selectionPageEveryoneText {
    return Intl.message(
      'Everyone',
      name: 'selectionPageEveryoneText',
      desc: '',
      args: [],
    );
  }

  /// `Stand out with Super Likes and 3x compatibility.`
  String get selectionPageContent2 {
    return Intl.message(
      'Stand out with Super Likes and 3x compatibility.',
      name: 'selectionPageContent2',
      desc: '',
      args: [],
    );
  }

  /// `UNLOCK TOP PICKS FEATURE`
  String get selectionPageContent3 {
    return Intl.message(
      'UNLOCK TOP PICKS FEATURE',
      name: 'selectionPageContent3',
      desc: '',
      args: [],
    );
  }

  /// `Remaining`
  String get selectionPageContent4 {
    return Intl.message(
      'Remaining',
      name: 'selectionPageContent4',
      desc: '',
      args: [],
    );
  }

  /// `hour`
  String get selectionPageHourText {
    return Intl.message(
      'hour',
      name: 'selectionPageHourText',
      desc: '',
      args: [],
    );
  }

  /// `minute`
  String get selectionPageMinuteText {
    return Intl.message(
      'minute',
      name: 'selectionPageMinuteText',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get locationScreenTitle {
    return Intl.message(
      'Address',
      name: 'locationScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select a country`
  String get locationScreenSelectCountry {
    return Intl.message(
      'Select a country',
      name: 'locationScreenSelectCountry',
      desc: '',
      args: [],
    );
  }

  /// `Select a province, city...`
  String get locationScreenSelectCity {
    return Intl.message(
      'Select a province, city...',
      name: 'locationScreenSelectCity',
      desc: '',
      args: [],
    );
  }

  /// `Select a city, district...`
  String get locationScreenSelectDistrict {
    return Intl.message(
      'Select a city, district...',
      name: 'locationScreenSelectDistrict',
      desc: '',
      args: [],
    );
  }

  /// `Select a commune, ward...`
  String get locationScreenSelectWard {
    return Intl.message(
      'Select a commune, ward...',
      name: 'locationScreenSelectWard',
      desc: '',
      args: [],
    );
  }

  /// `House number, alley...`
  String get locationScreenSelectAlley {
    return Intl.message(
      'House number, alley...',
      name: 'locationScreenSelectAlley',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get locationScreenConfirm {
    return Intl.message(
      'Confirm',
      name: 'locationScreenConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade to Finder Gold to see who's interested in you!`
  String get whoLikePageContentGold {
    return Intl.message(
      'Upgrade to Finder Gold to see who\'s interested in you!',
      name: 'whoLikePageContentGold',
      desc: '',
      args: [],
    );
  }

  /// `See who liked you`
  String get whoLikePageButtonGold {
    return Intl.message(
      'See who liked you',
      name: 'whoLikePageButtonGold',
      desc: '',
      args: [],
    );
  }

  /// `This is a list of people\nwho have liked you and your matches.`
  String get whoLikePageContent {
    return Intl.message(
      'This is a list of people\nwho have liked you and your matches.',
      name: 'whoLikePageContent',
      desc: '',
      args: [],
    );
  }

  /// `There is no data yet, please experience the app to connect with more people.`
  String get whoLikePageContentNull {
    return Intl.message(
      'There is no data yet, please experience the app to connect with more people.',
      name: 'whoLikePageContentNull',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notificationScreenTitle {
    return Intl.message(
      'Notification',
      name: 'notificationScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `No notifications have been sent to you yet, please experience the app and come back when there are push notifications!`
  String get notificationScreenContent {
    return Intl.message(
      'No notifications have been sent to you yet, please experience the app and come back when there are push notifications!',
      name: 'notificationScreenContent',
      desc: '',
      args: [],
    );
  }

  /// `New compatible`
  String get notificationScreenTitle2 {
    return Intl.message(
      'New compatible',
      name: 'notificationScreenTitle2',
      desc: '',
      args: [],
    );
  }

  /// `You've matched with someone. Go ahead and start getting to know each other!`
  String get notificationScreenContent_Match {
    return Intl.message(
      'You\'ve matched with someone. Go ahead and start getting to know each other!',
      name: 'notificationScreenContent_Match',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get notificationScreenView {
    return Intl.message(
      'View',
      name: 'notificationScreenView',
      desc: '',
      args: [],
    );
  }

  /// `The app need location permission to help you find around and match your love`
  String get notificationDialogLocation {
    return Intl.message(
      'The app need location permission to help you find around and match your love',
      name: 'notificationDialogLocation',
      desc: '',
      args: [],
    );
  }

  /// `Don't worry!`
  String get textTitleDialogLocation {
    return Intl.message(
      'Don\'t worry!',
      name: 'textTitleDialogLocation',
      desc: '',
      args: [],
    );
  }

  /// `Your location helps us display potential matches near you. Your exact location will not be shared.`
  String get textContentDialogLocation {
    return Intl.message(
      'Your location helps us display potential matches near you. Your exact location will not be shared.',
      name: 'textContentDialogLocation',
      desc: '',
      args: [],
    );
  }

  /// `How we use your location?`
  String get textVisibleDialogLocation {
    return Intl.message(
      'How we use your location?',
      name: 'textVisibleDialogLocation',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get textConfirmDialogLocation {
    return Intl.message(
      'Agree',
      name: 'textConfirmDialogLocation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get textCancelDialogLocation {
    return Intl.message(
      'Cancel',
      name: 'textCancelDialogLocation',
      desc: '',
      args: [],
    );
  }

  /// `We need your location. Turn on location and come back with the "Try again" button!`
  String get textContentSwitchLocation {
    return Intl.message(
      'We need your location. Turn on location and come back with the "Try again" button!',
      name: 'textContentSwitchLocation',
      desc: '',
      args: [],
    );
  }

  /// `I understand!`
  String get textButtonDialogLocation {
    return Intl.message(
      'I understand!',
      name: 'textButtonDialogLocation',
      desc: '',
      args: [],
    );
  }

  /// `Turn on location to "Match and chat" with new friends!`
  String get textContentRefreshLocation {
    return Intl.message(
      'Turn on location to "Match and chat" with new friends!',
      name: 'textContentRefreshLocation',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get textButtonRefreshLocation {
    return Intl.message(
      'Try again',
      name: 'textButtonRefreshLocation',
      desc: '',
      args: [],
    );
  }

  /// `New match!`
  String get notificationMatchTitle {
    return Intl.message(
      'New match!',
      name: 'notificationMatchTitle',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations! You have successfully matched with 'the other person'. Start connecting with each other in the messaging section.`
  String get notificationMatchContent {
    return Intl.message(
      'Congratulations! You have successfully matched with \'the other person\'. Start connecting with each other in the messaging section.',
      name: 'notificationMatchContent',
      desc: '',
      args: [],
    );
  }

  /// `I understand`
  String get notificationButtonMatch {
    return Intl.message(
      'I understand',
      name: 'notificationButtonMatch',
      desc: '',
      args: [],
    );
  }

  /// `I'm looking for`
  String get detailProfileLookingFor {
    return Intl.message(
      'I\'m looking for',
      name: 'detailProfileLookingFor',
      desc: '',
      args: [],
    );
  }

  /// `Introduce myself`
  String get detailProfileIntroduceTitle {
    return Intl.message(
      'Introduce myself',
      name: 'detailProfileIntroduceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Lifestyle`
  String get detailProfileLifestyleTitle {
    return Intl.message(
      'Lifestyle',
      name: 'detailProfileLifestyleTitle',
      desc: '',
      args: [],
    );
  }

  /// `Additional information about me`
  String get detailProfileAdditionalMeTitle {
    return Intl.message(
      'Additional information about me',
      name: 'detailProfileAdditionalMeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hobbies`
  String get detailProfileHobbiesTitle {
    return Intl.message(
      'Hobbies',
      name: 'detailProfileHobbiesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Share Profile`
  String get detailProfileShareTitle {
    return Intl.message(
      'Share Profile',
      name: 'detailProfileShareTitle',
      desc: '',
      args: [],
    );
  }

  /// `See what you think`
  String get detailProfileShareContent {
    return Intl.message(
      'See what you think',
      name: 'detailProfileShareContent',
      desc: '',
      args: [],
    );
  }

  /// `Block`
  String get detailProfileBlockTitle {
    return Intl.message(
      'Block',
      name: 'detailProfileBlockTitle',
      desc: '',
      args: [],
    );
  }

  /// `You won't see them, and they won't see you`
  String get detailProfileBlockContent {
    return Intl.message(
      'You won\'t see them, and they won\'t see you',
      name: 'detailProfileBlockContent',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get detailProfileReportTitle {
    return Intl.message(
      'Report',
      name: 'detailProfileReportTitle',
      desc: '',
      args: [],
    );
  }

  /// `Don't worry - we won't notify this person`
  String get detailProfileReportContent {
    return Intl.message(
      'Don\'t worry - we won\'t notify this person',
      name: 'detailProfileReportContent',
      desc: '',
      args: [],
    );
  }

  /// `Edit profile`
  String get updateProfileTitleAppbar {
    return Intl.message(
      'Edit profile',
      name: 'updateProfileTitleAppbar',
      desc: '',
      args: [],
    );
  }

  /// `Photos`
  String get updateProfilePhotosText {
    return Intl.message(
      'Photos',
      name: 'updateProfilePhotosText',
      desc: '',
      args: [],
    );
  }

  /// `About me`
  String get updateProfileAboutMeText {
    return Intl.message(
      'About me',
      name: 'updateProfileAboutMeText',
      desc: '',
      args: [],
    );
  }

  /// `Hobbies`
  String get updateProfileHobbiesText {
    return Intl.message(
      'Hobbies',
      name: 'updateProfileHobbiesText',
      desc: '',
      args: [],
    );
  }

  /// `Dating purpose`
  String get updateProfileDatingPurposeText {
    return Intl.message(
      'Dating purpose',
      name: 'updateProfileDatingPurposeText',
      desc: '',
      args: [],
    );
  }

  /// `Languages I know`
  String get updateProfileLanguagesIKnowText {
    return Intl.message(
      'Languages I know',
      name: 'updateProfileLanguagesIKnowText',
      desc: '',
      args: [],
    );
  }

  /// `Add language`
  String get updateProfileLanguagesHintText {
    return Intl.message(
      'Add language',
      name: 'updateProfileLanguagesHintText',
      desc: '',
      args: [],
    );
  }

  /// `Basic information`
  String get updateProfileBasicInformationText {
    return Intl.message(
      'Basic information',
      name: 'updateProfileBasicInformationText',
      desc: '',
      args: [],
    );
  }

  /// `Zodiac`
  String get basicInformationZodiacText {
    return Intl.message(
      'Zodiac',
      name: 'basicInformationZodiacText',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get basicInformationEducationText {
    return Intl.message(
      'Education',
      name: 'basicInformationEducationText',
      desc: '',
      args: [],
    );
  }

  /// `Future family`
  String get basicInformationFamilyText {
    return Intl.message(
      'Future family',
      name: 'basicInformationFamilyText',
      desc: '',
      args: [],
    );
  }

  /// `Personality type`
  String get basicInformationPersonalityText {
    return Intl.message(
      'Personality type',
      name: 'basicInformationPersonalityText',
      desc: '',
      args: [],
    );
  }

  /// `Communication style`
  String get basicInformationCommunicationText {
    return Intl.message(
      'Communication style',
      name: 'basicInformationCommunicationText',
      desc: '',
      args: [],
    );
  }

  /// `Love language`
  String get basicInformationLoveText {
    return Intl.message(
      'Love language',
      name: 'basicInformationLoveText',
      desc: '',
      args: [],
    );
  }

  /// `Lifestyle`
  String get updateProfileLifestyleText {
    return Intl.message(
      'Lifestyle',
      name: 'updateProfileLifestyleText',
      desc: '',
      args: [],
    );
  }

  /// `Pets`
  String get lifestylePetText {
    return Intl.message(
      'Pets',
      name: 'lifestylePetText',
      desc: '',
      args: [],
    );
  }

  /// `Alcohol consumption`
  String get lifestyleAlcoholText {
    return Intl.message(
      'Alcohol consumption',
      name: 'lifestyleAlcoholText',
      desc: '',
      args: [],
    );
  }

  /// `Do you smoke`
  String get lifestyleSmokeText {
    return Intl.message(
      'Do you smoke',
      name: 'lifestyleSmokeText',
      desc: '',
      args: [],
    );
  }

  /// `Exercise`
  String get lifestyleExerciseText {
    return Intl.message(
      'Exercise',
      name: 'lifestyleExerciseText',
      desc: '',
      args: [],
    );
  }

  /// `Dietary habits`
  String get lifestyleDietaryText {
    return Intl.message(
      'Dietary habits',
      name: 'lifestyleDietaryText',
      desc: '',
      args: [],
    );
  }

  /// `Media consumption`
  String get lifestyleMediaText {
    return Intl.message(
      'Media consumption',
      name: 'lifestyleMediaText',
      desc: '',
      args: [],
    );
  }

  /// `Sleep habits`
  String get lifestyleSleepText {
    return Intl.message(
      'Sleep habits',
      name: 'lifestyleSleepText',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get updateProfileGenderText {
    return Intl.message(
      'Gender',
      name: 'updateProfileGenderText',
      desc: '',
      args: [],
    );
  }

  /// `Company`
  String get updateProfileCompanyText {
    return Intl.message(
      'Company',
      name: 'updateProfileCompanyText',
      desc: '',
      args: [],
    );
  }

  /// `Add company`
  String get updateProfileCompanyHintText {
    return Intl.message(
      'Add company',
      name: 'updateProfileCompanyHintText',
      desc: '',
      args: [],
    );
  }

  /// `School`
  String get updateProfileSchoolText {
    return Intl.message(
      'School',
      name: 'updateProfileSchoolText',
      desc: '',
      args: [],
    );
  }

  /// `Add school`
  String get updateProfileSchoolHintText {
    return Intl.message(
      'Add school',
      name: 'updateProfileSchoolHintText',
      desc: '',
      args: [],
    );
  }

  /// `Currently living in`
  String get updateProfileLivingText {
    return Intl.message(
      'Currently living in',
      name: 'updateProfileLivingText',
      desc: '',
      args: [],
    );
  }

  /// `Add city`
  String get updateProfileLivingHintText {
    return Intl.message(
      'Add city',
      name: 'updateProfileLivingHintText',
      desc: '',
      args: [],
    );
  }

  /// `Sexual orientation`
  String get updateProfileSexualText {
    return Intl.message(
      'Sexual orientation',
      name: 'updateProfileSexualText',
      desc: '',
      args: [],
    );
  }

  /// `Additional information about me`
  String get basicInformationDialogTitle {
    return Intl.message(
      'Additional information about me',
      name: 'basicInformationDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add more information about yourself to let others know more about the amazing person you are.`
  String get basicInformationDialogContent {
    return Intl.message(
      'Add more information about yourself to let others know more about the amazing person you are.',
      name: 'basicInformationDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `What is your zodiac sign ?`
  String get basicInformationDialogZodiac {
    return Intl.message(
      'What is your zodiac sign ?',
      name: 'basicInformationDialogZodiac',
      desc: '',
      args: [],
    );
  }

  /// `What is your educational background ?`
  String get basicInformationDialogEducation {
    return Intl.message(
      'What is your educational background ?',
      name: 'basicInformationDialogEducation',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to have children ?`
  String get basicInformationDialogFamily {
    return Intl.message(
      'Do you want to have children ?',
      name: 'basicInformationDialogFamily',
      desc: '',
      args: [],
    );
  }

  /// `What is your personality type?`
  String get basicInformationDialogPersonality {
    return Intl.message(
      'What is your personality type?',
      name: 'basicInformationDialogPersonality',
      desc: '',
      args: [],
    );
  }

  /// `What is your love language?`
  String get basicInformationDialogLove {
    return Intl.message(
      'What is your love language?',
      name: 'basicInformationDialogLove',
      desc: '',
      args: [],
    );
  }

  /// `Now I'm looking for...`
  String get datingPurposeDialogTitle {
    return Intl.message(
      'Now I\'m looking for...',
      name: 'datingPurposeDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Share your purpose to find 'the one'!`
  String get datingPurposeDialogContent {
    return Intl.message(
      'Share your purpose to find \'the one\'!',
      name: 'datingPurposeDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `Interests`
  String get interestDialogTitle {
    return Intl.message(
      'Interests',
      name: 'interestDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `out of 5`
  String get interestDialogOutOfText {
    return Intl.message(
      'out of 5',
      name: 'interestDialogOutOfText',
      desc: '',
      args: [],
    );
  }

  /// `Interests help you easily find people with similar passions.\n Add 3-5 interests to your Profile to build more compatible connections.`
  String get interestDialogContent {
    return Intl.message(
      'Interests help you easily find people with similar passions.\n Add 3-5 interests to your Profile to build more compatible connections.',
      name: 'interestDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get interestDialogSearchText {
    return Intl.message(
      'Search',
      name: 'interestDialogSearchText',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get interestDialogDoneText {
    return Intl.message(
      'Done',
      name: 'interestDialogDoneText',
      desc: '',
      args: [],
    );
  }

  /// `Languages I know`
  String get languageDialogTitle {
    return Intl.message(
      'Languages I know',
      name: 'languageDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `out of 5`
  String get languageDialogOutOfText {
    return Intl.message(
      'out of 5',
      name: 'languageDialogOutOfText',
      desc: '',
      args: [],
    );
  }

  /// `Search language`
  String get languageDialogSearchText {
    return Intl.message(
      'Search language',
      name: 'languageDialogSearchText',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get languageDialogDoneText {
    return Intl.message(
      'Done',
      name: 'languageDialogDoneText',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade your Likes and Super Likes with the Platinum package.`
  String get sliderCustomSubTitle1 {
    return Intl.message(
      'Upgrade your Likes and Super Likes with the Platinum package.',
      name: 'sliderCustomSubTitle1',
      desc: '',
      args: [],
    );
  }

  /// `See who likes you and get instant compatibility with Finder Gold™`
  String get sliderCustomSubTitle2 {
    return Intl.message(
      'See who likes you and get instant compatibility with Finder Gold™',
      name: 'sliderCustomSubTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Infinite Likes. Unlimited Returns. Unlimited Passports. No Ads.`
  String get sliderCustomSubTitle3 {
    return Intl.message(
      'Infinite Likes. Unlimited Returns. Unlimited Passports. No Ads.',
      name: 'sliderCustomSubTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Buy Finder Platinum™`
  String get sliderCustomSubTitle4 {
    return Intl.message(
      'Buy Finder Platinum™',
      name: 'sliderCustomSubTitle4',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade to Finder Platinum™`
  String get sliderItemTitle1 {
    return Intl.message(
      'Upgrade to Finder Platinum™',
      name: 'sliderItemTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Elevate all your activities on Finder`
  String get sliderItemSubTitle1 {
    return Intl.message(
      'Elevate all your activities on Finder',
      name: 'sliderItemSubTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Get Finder Gold™`
  String get sliderItemTitle2 {
    return Intl.message(
      'Get Finder Gold™',
      name: 'sliderItemTitle2',
      desc: '',
      args: [],
    );
  }

  /// `See who Likes you & more features!`
  String get sliderItemSubTitle2 {
    return Intl.message(
      'See who Likes you & more features!',
      name: 'sliderItemSubTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Get Finder Plus®`
  String get sliderItemTitle3 {
    return Intl.message(
      'Get Finder Plus®',
      name: 'sliderItemTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Get unlimited Likes, Passport & more!`
  String get sliderItemSubTitle3 {
    return Intl.message(
      'Get unlimited Likes, Passport & more!',
      name: 'sliderItemSubTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Choose a package`
  String get pageFunctionVipContent1 {
    return Intl.message(
      'Choose a package',
      name: 'pageFunctionVipContent1',
      desc: '',
      args: [],
    );
  }

  /// `Included in Finder`
  String get pageFunctionVipContent2 {
    return Intl.message(
      'Included in Finder',
      name: 'pageFunctionVipContent2',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited likes`
  String get pageFunctionVipContent3 {
    return Intl.message(
      'Unlimited likes',
      name: 'pageFunctionVipContent3',
      desc: '',
      args: [],
    );
  }

  /// `5 Super Likes per month`
  String get pageFunctionVipContent4 {
    return Intl.message(
      '5 Super Likes per month',
      name: 'pageFunctionVipContent4',
      desc: '',
      args: [],
    );
  }

  /// `When you click Continue, you will be charged, and your subscription will automatically renew at the same price and duration until you cancel, anytime, through the Google Play settings, and you agree to our `
  String get pageFunctionVipContent5 {
    return Intl.message(
      'When you click Continue, you will be charged, and your subscription will automatically renew at the same price and duration until you cancel, anytime, through the Google Play settings, and you agree to our ',
      name: 'pageFunctionVipContent5',
      desc: '',
      args: [],
    );
  }

  /// `Terms`
  String get pageFunctionVipContent6 {
    return Intl.message(
      'Terms',
      name: 'pageFunctionVipContent6',
      desc: '',
      args: [],
    );
  }

  /// `.`
  String get pageFunctionVipContent7 {
    return Intl.message(
      '.',
      name: 'pageFunctionVipContent7',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get pageFunctionVipNextButton {
    return Intl.message(
      'Continue',
      name: 'pageFunctionVipNextButton',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get pageFunctionVipMonthText {
    return Intl.message(
      'Month',
      name: 'pageFunctionVipMonthText',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get pageFunctionVipPopularText {
    return Intl.message(
      'Popular',
      name: 'pageFunctionVipPopularText',
      desc: '',
      args: [],
    );
  }

  /// `Best Value`
  String get pageFunctionVipBestText {
    return Intl.message(
      'Best Value',
      name: 'pageFunctionVipBestText',
      desc: '',
      args: [],
    );
  }

  /// `Super Likes`
  String get pageFunctionVipSuperText {
    return Intl.message(
      'Super Likes',
      name: 'pageFunctionVipSuperText',
      desc: '',
      args: [],
    );
  }

  /// `Sexual orientation`
  String get sexualDialogTitle {
    return Intl.message(
      'Sexual orientation',
      name: 'sexualDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select up to 3`
  String get sexualDialogTitleSelectText {
    return Intl.message(
      'Select up to 3',
      name: 'sexualDialogTitleSelectText',
      desc: '',
      args: [],
    );
  }

  /// `Lifestyle`
  String get lifeStyleDialogTitle {
    return Intl.message(
      'Lifestyle',
      name: 'lifeStyleDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add more information about yourself to let others know more about the amazing person you are.`
  String get lifeStyleDialogContent {
    return Intl.message(
      'Add more information about yourself to let others know more about the amazing person you are.',
      name: 'lifeStyleDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `Do you have pets ?`
  String get lifeStyleDialogPetText {
    return Intl.message(
      'Do you have pets ?',
      name: 'lifeStyleDialogPetText',
      desc: '',
      args: [],
    );
  }

  /// `How do you usually consume alcohol ?`
  String get lifeStyleDialogAlcoholText {
    return Intl.message(
      'How do you usually consume alcohol ?',
      name: 'lifeStyleDialogAlcoholText',
      desc: '',
      args: [],
    );
  }

  /// `Do you smoke ?`
  String get lifeStyleDialogSmokeText {
    return Intl.message(
      'Do you smoke ?',
      name: 'lifeStyleDialogSmokeText',
      desc: '',
      args: [],
    );
  }

  /// `Do you exercise ?`
  String get lifeStyleDialogExerciseText {
    return Intl.message(
      'Do you exercise ?',
      name: 'lifeStyleDialogExerciseText',
      desc: '',
      args: [],
    );
  }

  /// `Your dietary preferences ?`
  String get lifeStyleDialogEatText {
    return Intl.message(
      'Your dietary preferences ?',
      name: 'lifeStyleDialogEatText',
      desc: '',
      args: [],
    );
  }

  /// `What is your level of social media activity?`
  String get lifeStyleDialogMediaText {
    return Intl.message(
      'What is your level of social media activity?',
      name: 'lifeStyleDialogMediaText',
      desc: '',
      args: [],
    );
  }

  /// `What are your sleeping habits like?`
  String get lifeStyleDialogSleepingText {
    return Intl.message(
      'What are your sleeping habits like?',
      name: 'lifeStyleDialogSleepingText',
      desc: '',
      args: [],
    );
  }

  /// `ADD PHOTOS`
  String get buttonAddPhotoText {
    return Intl.message(
      'ADD PHOTOS',
      name: 'buttonAddPhotoText',
      desc: '',
      args: [],
    );
  }

  /// `Empty`
  String get emptyText {
    return Intl.message(
      'Empty',
      name: 'emptyText',
      desc: '',
      args: [],
    );
  }

  /// `Get Super Likes!`
  String get bodyBuyPremiumTitle {
    return Intl.message(
      'Get Super Likes!',
      name: 'bodyBuyPremiumTitle',
      desc: '',
      args: [],
    );
  }

  /// `Super Likes help you stand out. Triple your chances of matching!`
  String get bodyBuyPremiumContent {
    return Intl.message(
      'Super Likes help you stand out. Triple your chances of matching!',
      name: 'bodyBuyPremiumContent',
      desc: '',
      args: [],
    );
  }

  /// `0 Super Likes`
  String get bodyBuyPremiumContentSuperLikesText {
    return Intl.message(
      '0 Super Likes',
      name: 'bodyBuyPremiumContentSuperLikesText',
      desc: '',
      args: [],
    );
  }

  /// `BUY MORE`
  String get bodyBuyPremiumButtonText {
    return Intl.message(
      'BUY MORE',
      name: 'bodyBuyPremiumButtonText',
      desc: '',
      args: [],
    );
  }

  /// `My Boosts`
  String get bodyBuyPremiumContentSuperBoostsText {
    return Intl.message(
      'My Boosts',
      name: 'bodyBuyPremiumContentSuperBoostsText',
      desc: '',
      args: [],
    );
  }

  /// `Subscription package`
  String get bodyBuyPremiumSubscriptionText {
    return Intl.message(
      'Subscription package',
      name: 'bodyBuyPremiumSubscriptionText',
      desc: '',
      args: [],
    );
  }

  /// `Savings`
  String get savingsText {
    return Intl.message(
      'Savings',
      name: 'savingsText',
      desc: '',
      args: [],
    );
  }

  /// `My Boosts`
  String get bottomDialogBoostTitle {
    return Intl.message(
      'My Boosts',
      name: 'bottomDialogBoostTitle',
      desc: '',
      args: [],
    );
  }

  /// `Boost your profile to the top of the area for 30 minutes for more matches.`
  String get bottomDialogBoostContent {
    return Intl.message(
      'Boost your profile to the top of the area for 30 minutes for more matches.',
      name: 'bottomDialogBoostContent',
      desc: '',
      args: [],
    );
  }

  /// `Boosts`
  String get bottomDialogBoostTitle2 {
    return Intl.message(
      'Boosts',
      name: 'bottomDialogBoostTitle2',
      desc: '',
      args: [],
    );
  }

  /// `remaining`
  String get bottomDialogBoostRemainingText {
    return Intl.message(
      'remaining',
      name: 'bottomDialogBoostRemainingText',
      desc: '',
      args: [],
    );
  }

  /// `Boosts`
  String get bottomDialogBoostButtonText {
    return Intl.message(
      'Boosts',
      name: 'bottomDialogBoostButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterdayText {
    return Intl.message(
      'Yesterday',
      name: 'yesterdayText',
      desc: '',
      args: [],
    );
  }

  /// `Invalid date and time format`
  String get invalidDateAndTimeErrorText {
    return Intl.message(
      'Invalid date and time format',
      name: 'invalidDateAndTimeErrorText',
      desc: '',
      args: [],
    );
  }

  /// `You've matched with someone. Go ahead and start getting to know each other!`
  String get compatibleContent {
    return Intl.message(
      'You\'ve matched with someone. Go ahead and start getting to know each other!',
      name: 'compatibleContent',
      desc: '',
      args: [],
    );
  }

  /// `sent you a message:`
  String get sentMessageNotification {
    return Intl.message(
      'sent you a message:',
      name: 'sentMessageNotification',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedbackText {
    return Intl.message(
      'Feedback',
      name: 'feedbackText',
      desc: '',
      args: [],
    );
  }

  /// `See`
  String get seenText {
    return Intl.message(
      'See',
      name: 'seenText',
      desc: '',
      args: [],
    );
  }

  /// `Top selection`
  String get titleTopUser {
    return Intl.message(
      'Top selection',
      name: 'titleTopUser',
      desc: '',
      args: [],
    );
  }

  /// `Likes`
  String get titleLike {
    return Intl.message(
      'Likes',
      name: 'titleLike',
      desc: '',
      args: [],
    );
  }

  /// `New Compatibility`
  String get messageScreenTitle1 {
    return Intl.message(
      'New Compatibility',
      name: 'messageScreenTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get messageScreenTitle2 {
    return Intl.message(
      'Message',
      name: 'messageScreenTitle2',
      desc: '',
      args: [],
    );
  }

  /// `likes`
  String get messageScreenLikesText {
    return Intl.message(
      'likes',
      name: 'messageScreenLikesText',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get messageScreenSearchText {
    return Intl.message(
      'Search',
      name: 'messageScreenSearchText',
      desc: '',
      args: [],
    );
  }

  /// `Type something...`
  String get messageScreenInputTypingText {
    return Intl.message(
      'Type something...',
      name: 'messageScreenInputTypingText',
      desc: '',
      args: [],
    );
  }

  /// `sent 1 photo`
  String get messageScreenSentImageText {
    return Intl.message(
      'sent 1 photo',
      name: 'messageScreenSentImageText',
      desc: '',
      args: [],
    );
  }

  /// `No messages yet`
  String get messageScreenNoMessage {
    return Intl.message(
      'No messages yet',
      name: 'messageScreenNoMessage',
      desc: '',
      args: [],
    );
  }

  /// `Your turn`
  String get messageScreenYourTurnText {
    return Intl.message(
      'Your turn',
      name: 'messageScreenYourTurnText',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get settingPageSubTitleAppBar {
    return Intl.message(
      'Setting',
      name: 'settingPageSubTitleAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get settingPageSubDoneText {
    return Intl.message(
      'Done',
      name: 'settingPageSubDoneText',
      desc: '',
      args: [],
    );
  }

  /// `Preferred Likes, See Who Likes You & More`
  String get settingPageSubTitle1 {
    return Intl.message(
      'Preferred Likes, See Who Likes You & More',
      name: 'settingPageSubTitle1',
      desc: '',
      args: [],
    );
  }

  /// `See who Likes you & more!`
  String get settingPageSubTitle2 {
    return Intl.message(
      'See who Likes you & more!',
      name: 'settingPageSubTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited Likes & More Benefits!`
  String get settingPageSubTitle3 {
    return Intl.message(
      'Unlimited Likes & More Benefits!',
      name: 'settingPageSubTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Get Super Likes`
  String get settingPageTitle1 {
    return Intl.message(
      'Get Super Likes',
      name: 'settingPageTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Super Likes make you stand out. 3X more likely to be compatible!`
  String get settingPageSubTitle4 {
    return Intl.message(
      'Super Likes make you stand out. 3X more likely to be compatible!',
      name: 'settingPageSubTitle4',
      desc: '',
      args: [],
    );
  }

  /// `Buy Speed Up`
  String get settingPageSubTitle5 {
    return Intl.message(
      'Buy Speed Up',
      name: 'settingPageSubTitle5',
      desc: '',
      args: [],
    );
  }

  /// `Use incognito mode`
  String get settingPageSubTitle6 {
    return Intl.message(
      'Use incognito mode',
      name: 'settingPageSubTitle6',
      desc: '',
      args: [],
    );
  }

  /// `Show profiles only to people you already like.`
  String get settingPageSubTitle7 {
    return Intl.message(
      'Show profiles only to people you already like.',
      name: 'settingPageSubTitle7',
      desc: '',
      args: [],
    );
  }

  /// `Search Settings`
  String get settingPageSearchText {
    return Intl.message(
      'Search Settings',
      name: 'settingPageSearchText',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get settingPageLogOutText {
    return Intl.message(
      'Log out',
      name: 'settingPageLogOutText',
      desc: '',
      args: [],
    );
  }

  /// `Change language`
  String get settingPageChangeLanguageText {
    return Intl.message(
      'Change language',
      name: 'settingPageChangeLanguageText',
      desc: '',
      args: [],
    );
  }

  /// `Current language`
  String get settingPageLanguageCurrentText {
    return Intl.message(
      'Current language',
      name: 'settingPageLanguageCurrentText',
      desc: '',
      args: [],
    );
  }

  /// `What is your sexual orientation ?`
  String get titleAddAddSexualOrientationPage {
    return Intl.message(
      'What is your sexual orientation ?',
      name: 'titleAddAddSexualOrientationPage',
      desc: '',
      args: [],
    );
  }

  /// `Select up to 3`
  String get textMaxItemSexual {
    return Intl.message(
      'Select up to 3',
      name: 'textMaxItemSexual',
      desc: '',
      args: [],
    );
  }

  /// `Straight`
  String get straight {
    return Intl.message(
      'Straight',
      name: 'straight',
      desc: '',
      args: [],
    );
  }

  /// `Gay`
  String get gay {
    return Intl.message(
      'Gay',
      name: 'gay',
      desc: '',
      args: [],
    );
  }

  /// `Lesbian`
  String get lesbian {
    return Intl.message(
      'Lesbian',
      name: 'lesbian',
      desc: '',
      args: [],
    );
  }

  /// `Bisexual`
  String get bisexual {
    return Intl.message(
      'Bisexual',
      name: 'bisexual',
      desc: '',
      args: [],
    );
  }

  /// `Ansexual`
  String get ansexual {
    return Intl.message(
      'Ansexual',
      name: 'ansexual',
      desc: '',
      args: [],
    );
  }

  /// `Demissexual`
  String get demissexual {
    return Intl.message(
      'Demissexual',
      name: 'demissexual',
      desc: '',
      args: [],
    );
  }

  /// `Pansexual`
  String get pansexual {
    return Intl.message(
      'Pansexual',
      name: 'pansexual',
      desc: '',
      args: [],
    );
  }

  /// `Transgender`
  String get transgender {
    return Intl.message(
      'Transgender',
      name: 'transgender',
      desc: '',
      args: [],
    );
  }

  /// `Undetermined or not sure about orientation`
  String get uncertain {
    return Intl.message(
      'Undetermined or not sure about orientation',
      name: 'uncertain',
      desc: '',
      args: [],
    );
  }

  /// `Now I am looking for...`
  String get titleAddDatingPurposePage {
    return Intl.message(
      'Now I am looking for...',
      name: 'titleAddDatingPurposePage',
      desc: '',
      args: [],
    );
  }

  /// `Share your purpose for finding 'The one'!`
  String get textContentDatingPurpose {
    return Intl.message(
      'Share your purpose for finding \'The one\'!',
      name: 'textContentDatingPurpose',
      desc: '',
      args: [],
    );
  }

  /// `Lover`
  String get lover {
    return Intl.message(
      'Lover',
      name: 'lover',
      desc: '',
      args: [],
    );
  }

  /// `Long-term dating`
  String get longTermDating {
    return Intl.message(
      'Long-term dating',
      name: 'longTermDating',
      desc: '',
      args: [],
    );
  }

  /// `Anything is possible`
  String get anything {
    return Intl.message(
      'Anything is possible',
      name: 'anything',
      desc: '',
      args: [],
    );
  }

  /// `Casual relationship`
  String get casualRelationship {
    return Intl.message(
      'Casual relationship',
      name: 'casualRelationship',
      desc: '',
      args: [],
    );
  }

  /// `New friends`
  String get newFriends {
    return Intl.message(
      'New friends',
      name: 'newFriends',
      desc: '',
      args: [],
    );
  }

  /// `Not sure yet`
  String get notSureYet {
    return Intl.message(
      'Not sure yet',
      name: 'notSureYet',
      desc: '',
      args: [],
    );
  }

  /// `What are your interests ?`
  String get titleAddInterestsPage {
    return Intl.message(
      'What are your interests ?',
      name: 'titleAddInterestsPage',
      desc: '',
      args: [],
    );
  }

  /// `You have your own unique interests. Let others know!`
  String get textContentInterests {
    return Intl.message(
      'You have your own unique interests. Let others know!',
      name: 'textContentInterests',
      desc: '',
      args: [],
    );
  }

  /// `Shopping`
  String get shopping {
    return Intl.message(
      'Shopping',
      name: 'shopping',
      desc: '',
      args: [],
    );
  }

  /// `Football`
  String get football {
    return Intl.message(
      'Football',
      name: 'football',
      desc: '',
      args: [],
    );
  }

  /// `Table tennis`
  String get tableTennis {
    return Intl.message(
      'Table tennis',
      name: 'tableTennis',
      desc: '',
      args: [],
    );
  }

  /// `Art exhibitions`
  String get arteExhibitions {
    return Intl.message(
      'Art exhibitions',
      name: 'arteExhibitions',
      desc: '',
      args: [],
    );
  }

  /// `TikTok`
  String get tikTok {
    return Intl.message(
      'TikTok',
      name: 'tikTok',
      desc: '',
      args: [],
    );
  }

  /// `E-sports`
  String get eSports {
    return Intl.message(
      'E-sports',
      name: 'eSports',
      desc: '',
      args: [],
    );
  }

  /// `Parties`
  String get parties {
    return Intl.message(
      'Parties',
      name: 'parties',
      desc: '',
      args: [],
    );
  }

  /// `Cosplay`
  String get cosplay {
    return Intl.message(
      'Cosplay',
      name: 'cosplay',
      desc: '',
      args: [],
    );
  }

  /// `Cars`
  String get cars {
    return Intl.message(
      'Cars',
      name: 'cars',
      desc: '',
      args: [],
    );
  }

  /// `Modern music`
  String get modernMusic {
    return Intl.message(
      'Modern music',
      name: 'modernMusic',
      desc: '',
      args: [],
    );
  }

  /// `Classical music`
  String get classicalMusic {
    return Intl.message(
      'Classical music',
      name: 'classicalMusic',
      desc: '',
      args: [],
    );
  }

  /// `Fashion`
  String get fashion {
    return Intl.message(
      'Fashion',
      name: 'fashion',
      desc: '',
      args: [],
    );
  }

  /// `Motorcycles`
  String get motorcycles {
    return Intl.message(
      'Motorcycles',
      name: 'motorcycles',
      desc: '',
      args: [],
    );
  }

  /// `Self-care`
  String get selfCare {
    return Intl.message(
      'Self-care',
      name: 'selfCare',
      desc: '',
      args: [],
    );
  }

  /// `Netflix`
  String get netflix {
    return Intl.message(
      'Netflix',
      name: 'netflix',
      desc: '',
      args: [],
    );
  }

  /// `Culinary`
  String get culinary {
    return Intl.message(
      'Culinary',
      name: 'culinary',
      desc: '',
      args: [],
    );
  }

  /// `Archery`
  String get archery {
    return Intl.message(
      'Archery',
      name: 'archery',
      desc: '',
      args: [],
    );
  }

  /// `Bubble tea`
  String get bubbleTea {
    return Intl.message(
      'Bubble tea',
      name: 'bubbleTea',
      desc: '',
      args: [],
    );
  }

  /// `Sneakers`
  String get sneakers {
    return Intl.message(
      'Sneakers',
      name: 'sneakers',
      desc: '',
      args: [],
    );
  }

  /// `Online gaming`
  String get onlineGaming {
    return Intl.message(
      'Online gaming',
      name: 'onlineGaming',
      desc: '',
      args: [],
    );
  }

  /// `Wine and beer`
  String get wineAndBeer {
    return Intl.message(
      'Wine and beer',
      name: 'wineAndBeer',
      desc: '',
      args: [],
    );
  }

  /// `Cycling`
  String get cycling {
    return Intl.message(
      'Cycling',
      name: 'cycling',
      desc: '',
      args: [],
    );
  }

  /// `Karaoke`
  String get karaoke {
    return Intl.message(
      'Karaoke',
      name: 'karaoke',
      desc: '',
      args: [],
    );
  }

  /// `Romantic movies`
  String get romanticMovies {
    return Intl.message(
      'Romantic movies',
      name: 'romanticMovies',
      desc: '',
      args: [],
    );
  }

  /// `Horror movies`
  String get horrorMovies {
    return Intl.message(
      'Horror movies',
      name: 'horrorMovies',
      desc: '',
      args: [],
    );
  }

  /// `Camping`
  String get camping {
    return Intl.message(
      'Camping',
      name: 'camping',
      desc: '',
      args: [],
    );
  }

  /// `Surfing`
  String get surfing {
    return Intl.message(
      'Surfing',
      name: 'surfing',
      desc: '',
      args: [],
    );
  }

  /// `Writing blogs`
  String get writingBlogs {
    return Intl.message(
      'Writing blogs',
      name: 'writingBlogs',
      desc: '',
      args: [],
    );
  }

  /// `Mountain climbing`
  String get mountainClimbing {
    return Intl.message(
      'Mountain climbing',
      name: 'mountainClimbing',
      desc: '',
      args: [],
    );
  }

  /// `Instagram`
  String get instagram {
    return Intl.message(
      'Instagram',
      name: 'instagram',
      desc: '',
      args: [],
    );
  }

  /// `Puzzles`
  String get puzzles {
    return Intl.message(
      'Puzzles',
      name: 'puzzles',
      desc: '',
      args: [],
    );
  }

  /// `Literature`
  String get literature {
    return Intl.message(
      'Literature',
      name: 'literature',
      desc: '',
      args: [],
    );
  }

  /// `Playing drums`
  String get playingDrums {
    return Intl.message(
      'Playing drums',
      name: 'playingDrums',
      desc: '',
      args: [],
    );
  }

  /// `Real estate`
  String get realEstate {
    return Intl.message(
      'Real estate',
      name: 'realEstate',
      desc: '',
      args: [],
    );
  }

  /// `Entrepreneurship`
  String get entrepreneurship {
    return Intl.message(
      'Entrepreneurship',
      name: 'entrepreneurship',
      desc: '',
      args: [],
    );
  }

  /// `Photography`
  String get photography {
    return Intl.message(
      'Photography',
      name: 'photography',
      desc: '',
      args: [],
    );
  }

  /// `Yoga`
  String get yoga {
    return Intl.message(
      'Yoga',
      name: 'yoga',
      desc: '',
      args: [],
    );
  }

  /// `Cooking`
  String get cooking {
    return Intl.message(
      'Cooking',
      name: 'cooking',
      desc: '',
      args: [],
    );
  }

  /// `Tennis`
  String get tennis {
    return Intl.message(
      'Tennis',
      name: 'tennis',
      desc: '',
      args: [],
    );
  }

  /// `Run`
  String get run {
    return Intl.message(
      'Run',
      name: 'run',
      desc: '',
      args: [],
    );
  }

  /// `Swimming`
  String get swimming {
    return Intl.message(
      'Swimming',
      name: 'swimming',
      desc: '',
      args: [],
    );
  }

  /// `Art`
  String get art {
    return Intl.message(
      'Art',
      name: 'art',
      desc: '',
      args: [],
    );
  }

  /// `Traveling`
  String get traveling {
    return Intl.message(
      'Traveling',
      name: 'traveling',
      desc: '',
      args: [],
    );
  }

  /// `Extreme`
  String get extreme {
    return Intl.message(
      'Extreme',
      name: 'extreme',
      desc: '',
      args: [],
    );
  }

  /// `Music`
  String get music {
    return Intl.message(
      'Music',
      name: 'music',
      desc: '',
      args: [],
    );
  }

  /// `Drink`
  String get drink {
    return Intl.message(
      'Drink',
      name: 'drink',
      desc: '',
      args: [],
    );
  }

  /// `Video games`
  String get videoGames {
    return Intl.message(
      'Video games',
      name: 'videoGames',
      desc: '',
      args: [],
    );
  }

  /// `Add recent photos of yourself`
  String get titleAddPhotosPage {
    return Intl.message(
      'Add recent photos of yourself',
      name: 'titleAddPhotosPage',
      desc: '',
      args: [],
    );
  }

  /// `Upload 2 photos to start finding like-minded individuals. Adding more photos will make your profile stand out to others.`
  String get textContentPhotos {
    return Intl.message(
      'Upload 2 photos to start finding like-minded individuals. Adding more photos will make your profile stand out to others.',
      name: 'textContentPhotos',
      desc: '',
      args: [],
    );
  }

  /// `It's all over, huh <3`
  String get titleDialogExit {
    return Intl.message(
      'It\'s all over, huh <3',
      name: 'titleDialogExit',
      desc: '',
      args: [],
    );
  }

  /// `If you're certain you won't sign up for Finder anymore, your information will be deleted.`
  String get contentDialogExitRegister {
    return Intl.message(
      'If you\'re certain you won\'t sign up for Finder anymore, your information will be deleted.',
      name: 'contentDialogExitRegister',
      desc: '',
      args: [],
    );
  }

  /// `We'll meet again at our next encounter!`
  String get contentDialogExitApp {
    return Intl.message(
      'We\'ll meet again at our next encounter!',
      name: 'contentDialogExitApp',
      desc: '',
      args: [],
    );
  }

  /// `Stay`
  String get textStayDialogExit {
    return Intl.message(
      'Stay',
      name: 'textStayDialogExit',
      desc: '',
      args: [],
    );
  }

  /// `Leave`
  String get textLeaveDialogExit {
    return Intl.message(
      'Leave',
      name: 'textLeaveDialogExit',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get textRefresh {
    return Intl.message(
      'Refresh',
      name: 'textRefresh',
      desc: '',
      args: [],
    );
  }

  /// `Capricorn`
  String get capricorn {
    return Intl.message(
      'Capricorn',
      name: 'capricorn',
      desc: '',
      args: [],
    );
  }

  /// `Aquarius`
  String get aquarius {
    return Intl.message(
      'Aquarius',
      name: 'aquarius',
      desc: '',
      args: [],
    );
  }

  /// `Pisces`
  String get pisces {
    return Intl.message(
      'Pisces',
      name: 'pisces',
      desc: '',
      args: [],
    );
  }

  /// `Aries`
  String get aries {
    return Intl.message(
      'Aries',
      name: 'aries',
      desc: '',
      args: [],
    );
  }

  /// `Taurus`
  String get taurus {
    return Intl.message(
      'Taurus',
      name: 'taurus',
      desc: '',
      args: [],
    );
  }

  /// `Gemini`
  String get gemini {
    return Intl.message(
      'Gemini',
      name: 'gemini',
      desc: '',
      args: [],
    );
  }

  /// `Cancer`
  String get cancer {
    return Intl.message(
      'Cancer',
      name: 'cancer',
      desc: '',
      args: [],
    );
  }

  /// `Leo`
  String get leo {
    return Intl.message(
      'Leo',
      name: 'leo',
      desc: '',
      args: [],
    );
  }

  /// `Virgo`
  String get virgo {
    return Intl.message(
      'Virgo',
      name: 'virgo',
      desc: '',
      args: [],
    );
  }

  /// `Libra`
  String get libra {
    return Intl.message(
      'Libra',
      name: 'libra',
      desc: '',
      args: [],
    );
  }

  /// `Scorpio`
  String get scorpio {
    return Intl.message(
      'Scorpio',
      name: 'scorpio',
      desc: '',
      args: [],
    );
  }

  /// `Sagittarius`
  String get sagittarius {
    return Intl.message(
      'Sagittarius',
      name: 'sagittarius',
      desc: '',
      args: [],
    );
  }

  /// `Bachelor's degree`
  String get bachelor {
    return Intl.message(
      'Bachelor\'s degree',
      name: 'bachelor',
      desc: '',
      args: [],
    );
  }

  /// `Bachelor's degree`
  String get currentlyInCollege {
    return Intl.message(
      'Bachelor\'s degree',
      name: 'currentlyInCollege',
      desc: '',
      args: [],
    );
  }

  /// `High school`
  String get highSchool {
    return Intl.message(
      'High school',
      name: 'highSchool',
      desc: '',
      args: [],
    );
  }

  /// `Doctorate`
  String get doctorate {
    return Intl.message(
      'Doctorate',
      name: 'doctorate',
      desc: '',
      args: [],
    );
  }

  /// `Postgraduate studies`
  String get postgraduateStudies {
    return Intl.message(
      'Postgraduate studies',
      name: 'postgraduateStudies',
      desc: '',
      args: [],
    );
  }

  /// `Master's degree`
  String get masterDegree {
    return Intl.message(
      'Master\'s degree',
      name: 'masterDegree',
      desc: '',
      args: [],
    );
  }

  /// `Vocational school`
  String get vocationalSchool {
    return Intl.message(
      'Vocational school',
      name: 'vocationalSchool',
      desc: '',
      args: [],
    );
  }

  /// `I want to have children`
  String get familyStyle1 {
    return Intl.message(
      'I want to have children',
      name: 'familyStyle1',
      desc: '',
      args: [],
    );
  }

  /// `I don't want to have children`
  String get familyStyle2 {
    return Intl.message(
      'I don\'t want to have children',
      name: 'familyStyle2',
      desc: '',
      args: [],
    );
  }

  /// `I already have children and want more`
  String get familyStyle3 {
    return Intl.message(
      'I already have children and want more',
      name: 'familyStyle3',
      desc: '',
      args: [],
    );
  }

  /// `I already have children and don't want more`
  String get familyStyle4 {
    return Intl.message(
      'I already have children and don\'t want more',
      name: 'familyStyle4',
      desc: '',
      args: [],
    );
  }

  /// `Not sure yet`
  String get familyStyle5 {
    return Intl.message(
      'Not sure yet',
      name: 'familyStyle5',
      desc: '',
      args: [],
    );
  }

  /// `Addicted to texting`
  String get communicateStyle1 {
    return Intl.message(
      'Addicted to texting',
      name: 'communicateStyle1',
      desc: '',
      args: [],
    );
  }

  /// `Prefer phone calls`
  String get communicateStyle2 {
    return Intl.message(
      'Prefer phone calls',
      name: 'communicateStyle2',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy video calls`
  String get communicateStyle3 {
    return Intl.message(
      'Enjoy video calls',
      name: 'communicateStyle3',
      desc: '',
      args: [],
    );
  }

  /// `Not much into texting`
  String get communicateStyle4 {
    return Intl.message(
      'Not much into texting',
      name: 'communicateStyle4',
      desc: '',
      args: [],
    );
  }

  /// `Prefer face-to-face meetings`
  String get communicateStyle5 {
    return Intl.message(
      'Prefer face-to-face meetings',
      name: 'communicateStyle5',
      desc: '',
      args: [],
    );
  }

  /// `Thoughtful gestures`
  String get languageOfLove1 {
    return Intl.message(
      'Thoughtful gestures',
      name: 'languageOfLove1',
      desc: '',
      args: [],
    );
  }

  /// `Gifts`
  String get languageOfLove2 {
    return Intl.message(
      'Gifts',
      name: 'languageOfLove2',
      desc: '',
      args: [],
    );
  }

  /// `Sweet gestures`
  String get languageOfLove3 {
    return Intl.message(
      'Sweet gestures',
      name: 'languageOfLove3',
      desc: '',
      args: [],
    );
  }

  /// `Compliments`
  String get languageOfLove4 {
    return Intl.message(
      'Compliments',
      name: 'languageOfLove4',
      desc: '',
      args: [],
    );
  }

  /// `Quality time together`
  String get languageOfLove5 {
    return Intl.message(
      'Quality time together',
      name: 'languageOfLove5',
      desc: '',
      args: [],
    );
  }

  /// `Dog`
  String get dog {
    return Intl.message(
      'Dog',
      name: 'dog',
      desc: '',
      args: [],
    );
  }

  /// `Cat`
  String get cat {
    return Intl.message(
      'Cat',
      name: 'cat',
      desc: '',
      args: [],
    );
  }

  /// `Reptile`
  String get reptile {
    return Intl.message(
      'Reptile',
      name: 'reptile',
      desc: '',
      args: [],
    );
  }

  /// `Amphibian`
  String get amphibian {
    return Intl.message(
      'Amphibian',
      name: 'amphibian',
      desc: '',
      args: [],
    );
  }

  /// `Bird`
  String get bird {
    return Intl.message(
      'Bird',
      name: 'bird',
      desc: '',
      args: [],
    );
  }

  /// `Fish`
  String get fish {
    return Intl.message(
      'Fish',
      name: 'fish',
      desc: '',
      args: [],
    );
  }

  /// `Turtle`
  String get turtle {
    return Intl.message(
      'Turtle',
      name: 'turtle',
      desc: '',
      args: [],
    );
  }

  /// `Hamster`
  String get hamster {
    return Intl.message(
      'Hamster',
      name: 'hamster',
      desc: '',
      args: [],
    );
  }

  /// `Rabbit`
  String get rabbit {
    return Intl.message(
      'Rabbit',
      name: 'rabbit',
      desc: '',
      args: [],
    );
  }

  /// `Like but don't own pets`
  String get likeButDontOwnPets {
    return Intl.message(
      'Like but don\'t own pets',
      name: 'likeButDontOwnPets',
      desc: '',
      args: [],
    );
  }

  /// `Don't own pets`
  String get dontOwnPets {
    return Intl.message(
      'Don\'t own pets',
      name: 'dontOwnPets',
      desc: '',
      args: [],
    );
  }

  /// `All types of pets`
  String get allTypesOfPets {
    return Intl.message(
      'All types of pets',
      name: 'allTypesOfPets',
      desc: '',
      args: [],
    );
  }

  /// `Interested in owning a pet`
  String get interestedInOwningPet {
    return Intl.message(
      'Interested in owning a pet',
      name: 'interestedInOwningPet',
      desc: '',
      args: [],
    );
  }

  /// `Allergic to animals`
  String get allergicToAnimals {
    return Intl.message(
      'Allergic to animals',
      name: 'allergicToAnimals',
      desc: '',
      args: [],
    );
  }

  /// `Not for me`
  String get drinkingStatus1 {
    return Intl.message(
      'Not for me',
      name: 'drinkingStatus1',
      desc: '',
      args: [],
    );
  }

  /// `Always sober`
  String get drinkingStatus2 {
    return Intl.message(
      'Always sober',
      name: 'drinkingStatus2',
      desc: '',
      args: [],
    );
  }

  /// `Drink responsibly`
  String get drinkingStatus3 {
    return Intl.message(
      'Drink responsibly',
      name: 'drinkingStatus3',
      desc: '',
      args: [],
    );
  }

  /// `On special occasions only`
  String get drinkingStatus4 {
    return Intl.message(
      'On special occasions only',
      name: 'drinkingStatus4',
      desc: '',
      args: [],
    );
  }

  /// `Social drinking on weekends`
  String get drinkingStatus5 {
    return Intl.message(
      'Social drinking on weekends',
      name: 'drinkingStatus5',
      desc: '',
      args: [],
    );
  }

  /// `Almost every evening`
  String get drinkingStatus6 {
    return Intl.message(
      'Almost every evening',
      name: 'drinkingStatus6',
      desc: '',
      args: [],
    );
  }

  /// `Smoke with friends`
  String get smokingStatus1 {
    return Intl.message(
      'Smoke with friends',
      name: 'smokingStatus1',
      desc: '',
      args: [],
    );
  }

  /// `Smoke while drinking`
  String get smokingStatus2 {
    return Intl.message(
      'Smoke while drinking',
      name: 'smokingStatus2',
      desc: '',
      args: [],
    );
  }

  /// `Do not smoke`
  String get smokingStatus3 {
    return Intl.message(
      'Do not smoke',
      name: 'smokingStatus3',
      desc: '',
      args: [],
    );
  }

  /// `Smoke regularly`
  String get smokingStatus4 {
    return Intl.message(
      'Smoke regularly',
      name: 'smokingStatus4',
      desc: '',
      args: [],
    );
  }

  /// `Trying to quit smoking`
  String get smokingStatus5 {
    return Intl.message(
      'Trying to quit smoking',
      name: 'smokingStatus5',
      desc: '',
      args: [],
    );
  }

  /// `Every day`
  String get sportsStatus1 {
    return Intl.message(
      'Every day',
      name: 'sportsStatus1',
      desc: '',
      args: [],
    );
  }

  /// `Regularly`
  String get sportsStatus2 {
    return Intl.message(
      'Regularly',
      name: 'sportsStatus2',
      desc: '',
      args: [],
    );
  }

  /// `Occasionally`
  String get sportsStatus3 {
    return Intl.message(
      'Occasionally',
      name: 'sportsStatus3',
      desc: '',
      args: [],
    );
  }

  /// `Do not exercise`
  String get sportsStatus4 {
    return Intl.message(
      'Do not exercise',
      name: 'sportsStatus4',
      desc: '',
      args: [],
    );
  }

  /// `Vegetarian`
  String get eatingStatus1 {
    return Intl.message(
      'Vegetarian',
      name: 'eatingStatus1',
      desc: '',
      args: [],
    );
  }

  /// `Vegan`
  String get eatingStatus2 {
    return Intl.message(
      'Vegan',
      name: 'eatingStatus2',
      desc: '',
      args: [],
    );
  }

  /// `Pedestrian (eat seafood and vegetables)`
  String get eatingStatus3 {
    return Intl.message(
      'Pedestrian (eat seafood and vegetables)',
      name: 'eatingStatus3',
      desc: '',
      args: [],
    );
  }

  /// `Carnivore (eat meat)`
  String get eatingStatus4 {
    return Intl.message(
      'Carnivore (eat meat)',
      name: 'eatingStatus4',
      desc: '',
      args: [],
    );
  }

  /// `No specific dietary restrictions`
  String get eatingStatus5 {
    return Intl.message(
      'No specific dietary restrictions',
      name: 'eatingStatus5',
      desc: '',
      args: [],
    );
  }

  /// `On a diet`
  String get eatingStatus6 {
    return Intl.message(
      'On a diet',
      name: 'eatingStatus6',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get eatingStatus7 {
    return Intl.message(
      'Other',
      name: 'eatingStatus7',
      desc: '',
      args: [],
    );
  }

  /// `Influence`
  String get socialNetworkStatus1 {
    return Intl.message(
      'Influence',
      name: 'socialNetworkStatus1',
      desc: '',
      args: [],
    );
  }

  /// `Active participant`
  String get socialNetworkStatus2 {
    return Intl.message(
      'Active participant',
      name: 'socialNetworkStatus2',
      desc: '',
      args: [],
    );
  }

  /// `Not active on social media`
  String get socialNetworkStatus3 {
    return Intl.message(
      'Not active on social media',
      name: 'socialNetworkStatus3',
      desc: '',
      args: [],
    );
  }

  /// `Silent observer`
  String get socialNetworkStatus4 {
    return Intl.message(
      'Silent observer',
      name: 'socialNetworkStatus4',
      desc: '',
      args: [],
    );
  }

  /// `Early riser`
  String get sleepingHabitsStatus1 {
    return Intl.message(
      'Early riser',
      name: 'sleepingHabitsStatus1',
      desc: '',
      args: [],
    );
  }

  /// `Night owl`
  String get sleepingHabitsStatus2 {
    return Intl.message(
      'Night owl',
      name: 'sleepingHabitsStatus2',
      desc: '',
      args: [],
    );
  }

  /// `Flexible schedule`
  String get sleepingHabitsStatus3 {
    return Intl.message(
      'Flexible schedule',
      name: 'sleepingHabitsStatus3',
      desc: '',
      args: [],
    );
  }

  /// `Show more`
  String get textShowMore {
    return Intl.message(
      'Show more',
      name: 'textShowMore',
      desc: '',
      args: [],
    );
  }

  /// `Crop photo`
  String get textAppBarCropPhoto {
    return Intl.message(
      'Crop photo',
      name: 'textAppBarCropPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get textNextButton {
    return Intl.message(
      'Continue',
      name: 'textNextButton',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get textSkipButton {
    return Intl.message(
      'Skip',
      name: 'textSkipButton',
      desc: '',
      args: [],
    );
  }

  /// `Who like you`
  String get whoLikePageTitle {
    return Intl.message(
      'Who like you',
      name: 'whoLikePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get textVersionApp {
    return Intl.message(
      'Version',
      name: 'textVersionApp',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get searchInputHint {
    return Intl.message(
      'Search',
      name: 'searchInputHint',
      desc: '',
      args: [],
    );
  }

  /// `Active State`
  String get settingActiveStateTitle {
    return Intl.message(
      'Active State',
      name: 'settingActiveStateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Manage active state`
  String get settingActiveStateContent {
    return Intl.message(
      'Manage active state',
      name: 'settingActiveStateContent',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingActiveStateContent_2 {
    return Intl.message(
      'Settings',
      name: 'settingActiveStateContent_2',
      desc: '',
      args: [],
    );
  }

  /// `Show active state`
  String get settingActiveStateSelect_1 {
    return Intl.message(
      'Show active state',
      name: 'settingActiveStateSelect_1',
      desc: '',
      args: [],
    );
  }

  /// `Active state shows on your profile if you have been active on the app in the last 2 hours`
  String get settingActiveStateSelect_1_Content {
    return Intl.message(
      'Active state shows on your profile if you have been active on the app in the last 2 hours',
      name: 'settingActiveStateSelect_1_Content',
      desc: '',
      args: [],
    );
  }

  /// `Show recent activity status`
  String get settingActiveStateSelect_2 {
    return Intl.message(
      'Show recent activity status',
      name: 'settingActiveStateSelect_2',
      desc: '',
      args: [],
    );
  }

  /// `Active state shows on your profile if you have been active on the app in the last 24 hours`
  String get settingActiveStateSelect_2_Content {
    return Intl.message(
      'Active state shows on your profile if you have been active on the app in the last 24 hours',
      name: 'settingActiveStateSelect_2_Content',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get settingContact {
    return Intl.message(
      'Contact us',
      name: 'settingContact',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get settingContact_Content {
    return Intl.message(
      'Help & Support',
      name: 'settingContact_Content',
      desc: '',
      args: [],
    );
  }

  /// `Community`
  String get settingCommunity {
    return Intl.message(
      'Community',
      name: 'settingCommunity',
      desc: '',
      args: [],
    );
  }

  /// `Community Rules`
  String get settingCommunity_Content_1 {
    return Intl.message(
      'Community Rules',
      name: 'settingCommunity_Content_1',
      desc: '',
      args: [],
    );
  }

  /// `Safety tips`
  String get settingCommunity_Content_2 {
    return Intl.message(
      'Safety tips',
      name: 'settingCommunity_Content_2',
      desc: '',
      args: [],
    );
  }

  /// `Share Finder`
  String get settingShareApp {
    return Intl.message(
      'Share Finder',
      name: 'settingShareApp',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get settingPrivacy {
    return Intl.message(
      'Privacy',
      name: 'settingPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get settingPrivacy_Policy {
    return Intl.message(
      'Privacy Policy',
      name: 'settingPrivacy_Policy',
      desc: '',
      args: [],
    );
  }

  /// `Privacy options`
  String get settingPrivacy_Policy_Option {
    return Intl.message(
      'Privacy options',
      name: 'settingPrivacy_Policy_Option',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get updateProfileUserHeightTitle {
    return Intl.message(
      'Height',
      name: 'updateProfileUserHeightTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add height`
  String get updateProfileUserHeightHint {
    return Intl.message(
      'Add height',
      name: 'updateProfileUserHeightHint',
      desc: '',
      args: [],
    );
  }

  /// `Let 'that person' know your height by adding it to your profile`
  String get updateProfileUserHeightContent {
    return Intl.message(
      'Let \'that person\' know your height by adding it to your profile',
      name: 'updateProfileUserHeightContent',
      desc: '',
      args: [],
    );
  }

  /// `Delete height`
  String get updateProfileUserHeightDelete {
    return Intl.message(
      'Delete height',
      name: 'updateProfileUserHeightDelete',
      desc: '',
      args: [],
    );
  }

  /// `Height unit`
  String get updateProfileUserHeightUnit {
    return Intl.message(
      'Height unit',
      name: 'updateProfileUserHeightUnit',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a number between 90 - 241`
  String get updateProfileUserHeightError {
    return Intl.message(
      'Please enter a number between 90 - 241',
      name: 'updateProfileUserHeightError',
      desc: '',
      args: [],
    );
  }

  /// `My favorite song`
  String get updateProfileUserMusicLove {
    return Intl.message(
      'My favorite song',
      name: 'updateProfileUserMusicLove',
      desc: '',
      args: [],
    );
  }

  /// `Spotify song search`
  String get updateProfileUserMusicSearch {
    return Intl.message(
      'Spotify song search',
      name: 'updateProfileUserMusicSearch',
      desc: '',
      args: [],
    );
  }

  /// `I don't want a favorite song`
  String get updateProfileUserMusicHide {
    return Intl.message(
      'I don\'t want a favorite song',
      name: 'updateProfileUserMusicHide',
      desc: '',
      args: [],
    );
  }

  /// `Popular on Spotify`
  String get updateProfileUserMusicPopular {
    return Intl.message(
      'Popular on Spotify',
      name: 'updateProfileUserMusicPopular',
      desc: '',
      args: [],
    );
  }

  /// `Control your profile`
  String get updateProfileUserControl {
    return Intl.message(
      'Control your profile',
      name: 'updateProfileUserControl',
      desc: '',
      args: [],
    );
  }

  /// `Hide my age`
  String get updateProfileUserMusicPopularAge {
    return Intl.message(
      'Hide my age',
      name: 'updateProfileUserMusicPopularAge',
      desc: '',
      args: [],
    );
  }

  /// `Hide my distance`
  String get updateProfileUserMusicPopularDistance {
    return Intl.message(
      'Hide my distance',
      name: 'updateProfileUserMusicPopularDistance',
      desc: '',
      args: [],
    );
  }

  /// `Create story`
  String get addStoryTitle {
    return Intl.message(
      'Create story',
      name: 'addStoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your story`
  String get myStoryTitle {
    return Intl.message(
      'Your story',
      name: 'myStoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get titleActive_1 {
    return Intl.message(
      'Active',
      name: 'titleActive_1',
      desc: '',
      args: [],
    );
  }

  /// `before`
  String get titleActive_2 {
    return Intl.message(
      'before',
      name: 'titleActive_2',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get titleActive_Day {
    return Intl.message(
      'days',
      name: 'titleActive_Day',
      desc: '',
      args: [],
    );
  }

  /// `Recent Activities`
  String get topUserRecentActivityTitle {
    return Intl.message(
      'Recent Activities',
      name: 'topUserRecentActivityTitle',
      desc: '',
      args: [],
    );
  }

  /// `People recently active on Finder. Hope you find your 'other half' soon.`
  String get topUserRecentActivityContent {
    return Intl.message(
      'People recently active on Finder. Hope you find your \'other half\' soon.',
      name: 'topUserRecentActivityContent',
      desc: '',
      args: [],
    );
  }

  /// `General interests`
  String get topUserSameHobbiesTitle {
    return Intl.message(
      'General interests',
      name: 'topUserSameHobbiesTitle',
      desc: '',
      args: [],
    );
  }

  /// `People who share the same interests as you. Check out their profiles and 'Match and Chat'!`
  String get topUserSameHobbiesContent {
    return Intl.message(
      'People who share the same interests as you. Check out their profiles and \'Match and Chat\'!',
      name: 'topUserSameHobbiesContent',
      desc: '',
      args: [],
    );
  }

  /// `See more`
  String get topUserButtonSeeMore {
    return Intl.message(
      'See more',
      name: 'topUserButtonSeeMore',
      desc: '',
      args: [],
    );
  }

  /// `Add song to Favorites`
  String get updateSpotifySelectTitle {
    return Intl.message(
      'Add song to Favorites',
      name: 'updateSpotifySelectTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select song`
  String get spotifySelectTitle {
    return Intl.message(
      'Select song',
      name: 'spotifySelectTitle',
      desc: '',
      args: [],
    );
  }

  /// `Find Spotify song`
  String get spotifySearchHint {
    return Intl.message(
      'Find Spotify song',
      name: 'spotifySearchHint',
      desc: '',
      args: [],
    );
  }

  /// `I don't want a favorite song`
  String get spotifyHideMusic {
    return Intl.message(
      'I don\'t want a favorite song',
      name: 'spotifyHideMusic',
      desc: '',
      args: [],
    );
  }

  /// `Popular on Spotify`
  String get spotifyPopularTitle {
    return Intl.message(
      'Popular on Spotify',
      name: 'spotifyPopularTitle',
      desc: '',
      args: [],
    );
  }

  /// `Play music`
  String get spotifyPlayMusic {
    return Intl.message(
      'Play music',
      name: 'spotifyPlayMusic',
      desc: '',
      args: [],
    );
  }

  /// `Play all songs`
  String get spotifyPlayMusicAll {
    return Intl.message(
      'Play all songs',
      name: 'spotifyPlayMusicAll',
      desc: '',
      args: [],
    );
  }

  /// `Start listening`
  String get spotifyPlayButton {
    return Intl.message(
      'Start listening',
      name: 'spotifyPlayButton',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any favorite song`
  String get noSpotifySong {
    return Intl.message(
      'Don\'t have any favorite song',
      name: 'noSpotifySong',
      desc: '',
      args: [],
    );
  }

  /// `Update your favorite song`
  String get updateFavoriteSongTitle {
    return Intl.message(
      'Update your favorite song',
      name: 'updateFavoriteSongTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you choose to face the problem frankly or avoid the problem?`
  String get suggestedMessage0 {
    return Intl.message(
      'Do you choose to face the problem frankly or avoid the problem?',
      name: 'suggestedMessage0',
      desc: '',
      args: [],
    );
  }

  /// `Do you choose to collect 20 billion VND or gain eternal youth?`
  String get suggestedMessage1 {
    return Intl.message(
      'Do you choose to collect 20 billion VND or gain eternal youth?',
      name: 'suggestedMessage1',
      desc: '',
      args: [],
    );
  }

  /// `Hello! Anything fun today?`
  String get suggestedMessage2 {
    return Intl.message(
      'Hello! Anything fun today?',
      name: 'suggestedMessage2',
      desc: '',
      args: [],
    );
  }

  /// `What do you regret the most?`
  String get suggestedMessage3 {
    return Intl.message(
      'What do you regret the most?',
      name: 'suggestedMessage3',
      desc: '',
      args: [],
    );
  }

  /// `What is your favorite word?`
  String get suggestedMessage4 {
    return Intl.message(
      'What is your favorite word?',
      name: 'suggestedMessage4',
      desc: '',
      args: [],
    );
  }

  /// `What is the real you like when no one is around?`
  String get suggestedMessage5 {
    return Intl.message(
      'What is the real you like when no one is around?',
      name: 'suggestedMessage5',
      desc: '',
      args: [],
    );
  }

  /// `Hello! Is everything okay?`
  String get suggestedMessage6 {
    return Intl.message(
      'Hello! Is everything okay?',
      name: 'suggestedMessage6',
      desc: '',
      args: [],
    );
  }

  /// `Start chatting with `
  String get startChatTitle {
    return Intl.message(
      'Start chatting with ',
      name: 'startChatTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tap to see other suggestions`
  String get seeOtherSuggestionTitle {
    return Intl.message(
      'Tap to see other suggestions',
      name: 'seeOtherSuggestionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get sendSuggestedMessageButtonTitle {
    return Intl.message(
      'Send',
      name: 'sendSuggestedMessageButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reason`
  String get reportReasonTab_1 {
    return Intl.message(
      'Reason',
      name: 'reportReasonTab_1',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get reportReasonTab_2 {
    return Intl.message(
      'Details',
      name: 'reportReasonTab_2',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get reportReasonTab_3 {
    return Intl.message(
      'Send',
      name: 'reportReasonTab_3',
      desc: '',
      args: [],
    );
  }

  /// `What issue do you want to report?`
  String get reportReasonTitle {
    return Intl.message(
      'What issue do you want to report?',
      name: 'reportReasonTitle',
      desc: '',
      args: [],
    );
  }

  /// `We care about you and what you know and need to say. What you share with us will be kept confidential.`
  String get reportReasonContent {
    return Intl.message(
      'We care about you and what you know and need to say. What you share with us will be kept confidential.',
      name: 'reportReasonContent',
      desc: '',
      args: [],
    );
  }

  /// `This person's biography`
  String get reportReason_1 {
    return Intl.message(
      'This person\'s biography',
      name: 'reportReason_1',
      desc: '',
      args: [],
    );
  }

  /// `This person's profile photo`
  String get reportReason_2 {
    return Intl.message(
      'This person\'s profile photo',
      name: 'reportReason_2',
      desc: '',
      args: [],
    );
  }

  /// `Something else happened`
  String get reportReason_3 {
    return Intl.message(
      'Something else happened',
      name: 'reportReason_3',
      desc: '',
      args: [],
    );
  }

  /// `What is the reason for your report?`
  String get reportDetailReasonTitle {
    return Intl.message(
      'What is the reason for your report?',
      name: 'reportDetailReasonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Misleading profile or behavior`
  String get reportDetailReason_1 {
    return Intl.message(
      'Misleading profile or behavior',
      name: 'reportDetailReason_1',
      desc: '',
      args: [],
    );
  }

  /// `Fake profile, fraud, not the person in the profile`
  String get reportDetailReason_1_1 {
    return Intl.message(
      'Fake profile, fraud, not the person in the profile',
      name: 'reportDetailReason_1_1',
      desc: '',
      args: [],
    );
  }

  /// `Someone is offering something for sale that I think is a scam`
  String get reportDetailReason_1_2 {
    return Intl.message(
      'Someone is offering something for sale that I think is a scam',
      name: 'reportDetailReason_1_2',
      desc: '',
      args: [],
    );
  }

  /// `Related to people under 18 years old`
  String get reportDetailReason_1_3 {
    return Intl.message(
      'Related to people under 18 years old',
      name: 'reportDetailReason_1_3',
      desc: '',
      args: [],
    );
  }

  /// `Harassment or bad behavior`
  String get reportDetailReason_2 {
    return Intl.message(
      'Harassment or bad behavior',
      name: 'reportDetailReason_2',
      desc: '',
      args: [],
    );
  }

  /// `Nudity or sexual content`
  String get reportDetailReason_2_1 {
    return Intl.message(
      'Nudity or sexual content',
      name: 'reportDetailReason_2_1',
      desc: '',
      args: [],
    );
  }

  /// `Abusive/hateful/threatening behavior`
  String get reportDetailReason_2_2 {
    return Intl.message(
      'Abusive/hateful/threatening behavior',
      name: 'reportDetailReason_2_2',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to share any more details?`
  String get reportConfirmReasonTitle {
    return Intl.message(
      'Do you want to share any more details?',
      name: 'reportConfirmReasonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add comment`
  String get reportConfirmReasonCommentTitle {
    return Intl.message(
      'Add comment',
      name: 'reportConfirmReasonCommentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please provide more details about what you are reporting.`
  String get reportConfirmReasonCommentHint {
    return Intl.message(
      'Please provide more details about what you are reporting.',
      name: 'reportConfirmReasonCommentHint',
      desc: '',
      args: [],
    );
  }

  /// `We won't let the person know you're reporting them.`
  String get reportReasonButtonContent {
    return Intl.message(
      'We won\'t let the person know you\'re reporting them.',
      name: 'reportReasonButtonContent',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get reportReasonButtonNext {
    return Intl.message(
      'Continue',
      name: 'reportReasonButtonNext',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get reportReasonButtonSend {
    return Intl.message(
      'Send',
      name: 'reportReasonButtonSend',
      desc: '',
      args: [],
    );
  }

  /// `Your report has been sent to our admin department! Thank you very much for your comments <3`
  String get reportReasonDialogContent {
    return Intl.message(
      'Your report has been sent to our admin department! Thank you very much for your comments <3',
      name: 'reportReasonDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `If you want to meet and talk directly to each other instead of texting. Try to see if you both have a good taste by making a video call.`
  String get textContentCallVideo {
    return Intl.message(
      'If you want to meet and talk directly to each other instead of texting. Try to see if you both have a good taste by making a video call.',
      name: 'textContentCallVideo',
      desc: '',
      args: [],
    );
  }

  /// `Call now`
  String get textSubmitCallVideo {
    return Intl.message(
      'Call now',
      name: 'textSubmitCallVideo',
      desc: '',
      args: [],
    );
  }

  /// `Payment management`
  String get payAccountManagementTitle {
    return Intl.message(
      'Payment management',
      name: 'payAccountManagementTitle',
      desc: '',
      args: [],
    );
  }

  /// `Manage Google Play Account`
  String get paymentGooglePlayTitle {
    return Intl.message(
      'Manage Google Play Account',
      name: 'paymentGooglePlayTitle',
      desc: '',
      args: [],
    );
  }

  /// `Bill Management`
  String get billManagementTitle {
    return Intl.message(
      'Bill Management',
      name: 'billManagementTitle',
      desc: '',
      args: [],
    );
  }

  /// `Payment account`
  String get paymentAccountTitle {
    return Intl.message(
      'Payment account',
      name: 'paymentAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `No invoices have been created yet! Buy the Vip package to make your profile stand out more than ever`
  String get billEmptyData {
    return Intl.message(
      'No invoices have been created yet! Buy the Vip package to make your profile stand out more than ever',
      name: 'billEmptyData',
      desc: '',
      args: [],
    );
  }

  /// `Buy Vip now`
  String get billPayButtonTittle {
    return Intl.message(
      'Buy Vip now',
      name: 'billPayButtonTittle',
      desc: '',
      args: [],
    );
  }

  /// `Reference number`
  String get billNameId {
    return Intl.message(
      'Reference number',
      name: 'billNameId',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get billNameContentPay {
    return Intl.message(
      'Content',
      name: 'billNameContentPay',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get billNameTitle {
    return Intl.message(
      'Account',
      name: 'billNameTitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get billEmailTitle {
    return Intl.message(
      'Email',
      name: 'billEmailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Payment mode`
  String get billPaymentModeTitle {
    return Intl.message(
      'Payment mode',
      name: 'billPaymentModeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Payee`
  String get billPayeeTitle {
    return Intl.message(
      'Payee',
      name: 'billPayeeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get billTimeTitle {
    return Intl.message(
      'Time',
      name: 'billTimeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterdayText_2 {
    return Intl.message(
      'Yesterday',
      name: 'yesterdayText_2',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get settingThemeTitle {
    return Intl.message(
      'Theme',
      name: 'settingThemeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Using the system theme will automatically adjust Tinder's theme to suit your system settings.`
  String get settingThemeContent {
    return Intl.message(
      'Using the system theme will automatically adjust Tinder\'s theme to suit your system settings.',
      name: 'settingThemeContent',
      desc: '',
      args: [],
    );
  }

  /// `System interface`
  String get settingThemeSystem {
    return Intl.message(
      'System interface',
      name: 'settingThemeSystem',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get settingThemeLight {
    return Intl.message(
      'Light Mode',
      name: 'settingThemeLight',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get settingThemeDark {
    return Intl.message(
      'Dark mode',
      name: 'settingThemeDark',
      desc: '',
      args: [],
    );
  }

  /// `Total amount`
  String get paymentTotalPrice {
    return Intl.message(
      'Total amount',
      name: 'paymentTotalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Your bill`
  String get billDetailTitle {
    return Intl.message(
      'Your bill',
      name: 'billDetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your purchase`
  String get billDetailContent_1 {
    return Intl.message(
      'Thank you for your purchase',
      name: 'billDetailContent_1',
      desc: '',
      args: [],
    );
  }

  /// `Save the invoice image below`
  String get billDetailContent_2 {
    return Intl.message(
      'Save the invoice image below',
      name: 'billDetailContent_2',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get billButtonSave {
    return Intl.message(
      'Save',
      name: 'billButtonSave',
      desc: '',
      args: [],
    );
  }

  /// `Finder uses these preferences to recommend matches. Some match suggestions may not meet your criteria.`
  String get settingLocationContent {
    return Intl.message(
      'Finder uses these preferences to recommend matches. Some match suggestions may not meet your criteria.',
      name: 'settingLocationContent',
      desc: '',
      args: [],
    );
  }

  /// `Payment methods`
  String get paymentMethodsTitle {
    return Intl.message(
      'Payment methods',
      name: 'paymentMethodsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Acceleration`
  String get paymentMethods_GooglePlay_Title {
    return Intl.message(
      'Acceleration',
      name: 'paymentMethods_GooglePlay_Title',
      desc: '',
      args: [],
    );
  }

  /// `BUY NOW`
  String get paymentMethods_GooglePlay_Button {
    return Intl.message(
      'BUY NOW',
      name: 'paymentMethods_GooglePlay_Button',
      desc: '',
      args: [],
    );
  }

  /// `When you click buy now, you will have to pay via your card. Set up your account and you agree to our terms`
  String get paymentMethods_GooglePlay_Content {
    return Intl.message(
      'When you click buy now, you will have to pay via your card. Set up your account and you agree to our terms',
      name: 'paymentMethods_GooglePlay_Content',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get paymentMethods_GooglePlay_Total {
    return Intl.message(
      'Total',
      name: 'paymentMethods_GooglePlay_Total',
      desc: '',
      args: [],
    );
  }

  /// `tax`
  String get paymentMethods_GooglePlay_Tax {
    return Intl.message(
      'tax',
      name: 'paymentMethods_GooglePlay_Tax',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred. Please try again later!`
  String get paymentMethods_GooglePlay_Error {
    return Intl.message(
      'An error occurred. Please try again later!',
      name: 'paymentMethods_GooglePlay_Error',
      desc: '',
      args: [],
    );
  }

  /// `Share Tinder`
  String get setting_share_finder {
    return Intl.message(
      'Share Tinder',
      name: 'setting_share_finder',
      desc: '',
      args: [],
    );
  }

  /// `Active time`
  String get setting_time_active {
    return Intl.message(
      'Active time',
      name: 'setting_time_active',
      desc: '',
      args: [],
    );
  }

  /// `day`
  String get setting_time_day {
    return Intl.message(
      'day',
      name: 'setting_time_day',
      desc: '',
      args: [],
    );
  }

  /// `hour`
  String get setting_time_hour {
    return Intl.message(
      'hour',
      name: 'setting_time_hour',
      desc: '',
      args: [],
    );
  }

  /// `minute`
  String get setting_time_minute {
    return Intl.message(
      'minute',
      name: 'setting_time_minute',
      desc: '',
      args: [],
    );
  }

  /// `second`
  String get setting_time_second {
    return Intl.message(
      'second',
      name: 'setting_time_second',
      desc: '',
      args: [],
    );
  }

  /// `Woww!!! You used it and it's active`
  String get setting_time_active_content_1 {
    return Intl.message(
      'Woww!!! You used it and it\'s active',
      name: 'setting_time_active_content_1',
      desc: '',
      args: [],
    );
  }

  /// `at Finder. Hope you find your 'other half'!️️ ❤️`
  String get setting_time_active_content_2 {
    return Intl.message(
      'at Finder. Hope you find your \'other half\'!️️ ❤️',
      name: 'setting_time_active_content_2',
      desc: '',
      args: [],
    );
  }

  /// `Successful boost! Your profile will be featured for 30 minutes. Hope you find your 'other half' soon <3`
  String get content_boosts {
    return Intl.message(
      'Successful boost! Your profile will be featured for 30 minutes. Hope you find your \'other half\' soon <3',
      name: 'content_boosts',
      desc: '',
      args: [],
    );
  }

  /// `You are already in acceleration time! Or wait for the rotation and accelerate again!`
  String get content_boosts_false {
    return Intl.message(
      'You are already in acceleration time! Or wait for the rotation and accelerate again!',
      name: 'content_boosts_false',
      desc: '',
      args: [],
    );
  }

  /// `Please verify the photo`
  String get verifyAvatarDiscoverTitle {
    return Intl.message(
      'Please verify the photo',
      name: 'verifyAvatarDiscoverTitle',
      desc: '',
      args: [],
    );
  }

  /// `Photo verified`
  String get verifyAvatarDiscoverTitle_Success {
    return Intl.message(
      'Photo verified',
      name: 'verifyAvatarDiscoverTitle_Success',
      desc: '',
      args: [],
    );
  }

  /// `Try now`
  String get verifyAvatarDiscoverTitle_Button {
    return Intl.message(
      'Try now',
      name: 'verifyAvatarDiscoverTitle_Button',
      desc: '',
      args: [],
    );
  }

  /// `Verify now`
  String get verifyAvatarPageTitle_Button {
    return Intl.message(
      'Verify now',
      name: 'verifyAvatarPageTitle_Button',
      desc: '',
      args: [],
    );
  }

  /// `Face`
  String get verifyAvatarPageTitle {
    return Intl.message(
      'Face',
      name: 'verifyAvatarPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Photo verification was successful. Continue using Finder with a green 'reputable' check mark!`
  String get verifyAvatarPageContent_Success {
    return Intl.message(
      'Photo verification was successful. Continue using Finder with a green \'reputable\' check mark!',
      name: 'verifyAvatarPageContent_Success',
      desc: '',
      args: [],
    );
  }

  /// `Photo verification failed. Please try again later!`
  String get verifyAvatarPageContent_Fall {
    return Intl.message(
      'Photo verification failed. Please try again later!',
      name: 'verifyAvatarPageContent_Fall',
      desc: '',
      args: [],
    );
  }

  /// `Payment account management`
  String get paymentAccountManagerTitle {
    return Intl.message(
      'Payment account management',
      name: 'paymentAccountManagerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Payment method`
  String get paymentAccountManagerContent {
    return Intl.message(
      'Payment method',
      name: 'paymentAccountManagerContent',
      desc: '',
      args: [],
    );
  }

  /// `Connect Paypal account`
  String get paymentAccountManager_Paypal {
    return Intl.message(
      'Connect Paypal account',
      name: 'paymentAccountManager_Paypal',
      desc: '',
      args: [],
    );
  }

  /// `Add credit card`
  String get paymentAccountManager_Card {
    return Intl.message(
      'Add credit card',
      name: 'paymentAccountManager_Card',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get paymentAccountManagerSupportTitle {
    return Intl.message(
      'Contact us',
      name: 'paymentAccountManagerSupportTitle',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get paymentAccountManagerSupportContent {
    return Intl.message(
      'Help',
      name: 'paymentAccountManagerSupportContent',
      desc: '',
      args: [],
    );
  }

  /// `See answers to any purchasing or payment questions`
  String get paymentAccountManagerSupportContent_2 {
    return Intl.message(
      'See answers to any purchasing or payment questions',
      name: 'paymentAccountManagerSupportContent_2',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'lo'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
