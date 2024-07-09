import 'package:shared_preferences/shared_preferences.dart';

late HelpersFunctions helpersFunctions;

class HelpersFunctions {
  SharedPreferences? _pref;

  static String sharedPreferenceUserIdKey = "IDKEY";

  static String sharedPreferenceNameUserKey = "NAMEKEY";
  static String sharedPreferenceAvatarUserKey = "AVATARKEY";
  static String sharedPreferenceTokenKey = "TOKENKEY";

  static Future<dynamic> getInstance() async {
    var preferences = HelpersFunctions();
    preferences._pref = await SharedPreferences.getInstance();
    return preferences;
  }

  // ----------------------- languageApp
  final _isInLogin = "login_first";

  get languageApp {
    return _pref?.getBool(_isInLogin) ?? false;
  }

  set languageApp(value) {
    _pref?.setBool(_isInLogin, value);
  }

  // ----------------------- id user
  final _idUser = "Id_User";

  get idUser {
    return _pref?.getString(_idUser) ?? "";
  }

  set idUser(value) {
    _pref?.setString(_idUser, value);
  }

  // ----------------------- name user
  final _fullName = "Full Name";

  get fullName {
    return _pref?.getString(_fullName) ?? "";
  }

  set fullName(value) {
    _pref?.setString(_fullName, value);
  }

  // ----------------------- name user
  final _idCall = "Id Call";

  get callId {
    return _pref?.getString(_idCall) ?? "";
  }

  set callId(value) {
    _pref?.setString(_idCall, value);
  }

  final _timeEnd = "Time End";

  get timeEnd {
    return _pref?.getString(_timeEnd) ?? "0";
  }

  set timeEnd(value) {
    _pref?.setString(_timeEnd, value);
  }

  final _timeStart = "Time start";

  get timeStart {
    return _pref?.getString(_timeStart) ?? "0";
  }

  set timeStart(value) {
    _pref?.setString(_timeStart, value);
  }

  final _requestToShow = "requestToShow";

  get requestToShow {
    return _pref?.getInt(_requestToShow) ?? 0;
  }

  set requestToShow(value) {
    _pref?.setInt(_requestToShow, value);
  }

  final _pathDocument = "PathDocument";

  get pathDocument {
    return _pref?.getString(_pathDocument) ?? '';
  }

  set pathDocument(value) {
    _pref?.setString(_pathDocument, value);
  }

  final _userLatitude = "user_latitude";

  get userLatitude {
    return _pref?.getDouble(_userLatitude) ?? 0;
  }

  set userLatitude(value) {
    _pref?.setDouble(_userLatitude, value);
  }

  final _userLongitude = "user_longitude";

  get userLongitude {
    return _pref?.getDouble(_userLongitude) ?? 0;
  }

  set userLongitude(value) {
    _pref?.setDouble(_userLongitude, value);
  }

  final _maxDistance = "max_distance";

  get maxDistance {
    return _pref?.getDouble(_maxDistance) ?? 50;
  }

  set maxDistance(value) {
    _pref?.setDouble(_maxDistance, value);
  }

  final _accessDistance = "AccessDistance";

  get accessDistance {
    return _pref?.getBool(_accessDistance) ?? false;
  }

  set accessDistance(value) {
    _pref?.setBool(_accessDistance, value);
  }

  final _accessAge = "AccessAge";

  get accessAge {
    return _pref?.getBool(_accessAge) ?? false;
  }

  set accessAge(value) {
    _pref?.setBool(_accessAge, value);
  }

  final _maxPhoto = "max_photo";

  get maxPhoto {
    return _pref?.getDouble(_maxPhoto) ?? 1;
  }

  set maxPhoto(value) {
    _pref?.setDouble(_maxPhoto, value);
  }

  final _ageMinToShow = "ageMinToShow";
  final _ageMaxToShow = "ageMaxToShow";

  get ageMinToShow {
    return _pref?.getDouble(_ageMinToShow) ?? 18;
  }

  set ageMinToShow(value) {
    _pref?.setDouble(_ageMinToShow, value);
  }

  get ageMaxToShow {
    return _pref?.getDouble(_ageMaxToShow) ?? 30;
  }

  set ageMaxToShow(value) {
    _pref?.setDouble(_ageMaxToShow, value);
  }

  final _accessBio = "AccessBio";

  get accessBio {
    return _pref?.getBool(_accessBio) ?? false;
  }

  set accessBio(value) {
    _pref?.setBool(_accessBio, value);
  }

  final _lastFetchedTimestamp = "last_fetched_timestamp";

  get lastFetchedTimestamp {
    return _pref?.getDouble(_lastFetchedTimestamp) ?? 0;
  }

  set lastFetchedTimestamp(value) {
    _pref?.setDouble(_lastFetchedTimestamp, value);
  }

  // save query data
  final _interests = "_interests";

  get interests {
    return _pref?.getInt(_interests) ?? -1;
  }

  set interests(value) {
    _pref?.setInt(_interests, value);
  }

  final _lookingFor = "_lookingFor";

  get lookingFor {
    return _pref?.getInt(_lookingFor) ?? -1;
  }

  set lookingFor(value) {
    _pref?.setInt(_lookingFor, value);
  }

  final _zodiac = "_zodiac";

  get zodiac {
    return _pref?.getInt(_zodiac) ?? -1;
  }

  set zodiac(value) {
    _pref?.setInt(_zodiac, value);
  }

  final _education = "_education";

  get education {
    return _pref?.getInt(_education) ?? -1;
  }

  set education(value) {
    _pref?.setInt(_education, value);
  }

  final _futureFamily = "_futureFamily";

  get futureFamily {
    return _pref?.getInt(_futureFamily) ?? -1;
  }

  set futureFamily(value) {
    _pref?.setInt(_futureFamily, value);
  }

  final _personType = "_personType";

  get personType {
    return _pref?.getInt(_personType) ?? -1;
  }

  set personType(value) {
    _pref?.setInt(_personType, value);
  }

  final _communicationStyle = "_communicationStyle";

  get communicationStyle {
    return _pref?.getInt(_communicationStyle) ?? -1;
  }

  set communicationStyle(value) {
    _pref?.setInt(_communicationStyle, value);
  }

  final _loveLanguage = "_loveLanguage";

  get loveLanguage {
    return _pref?.getInt(_loveLanguage) ?? -1;
  }

  set loveLanguage(value) {
    _pref?.setInt(_loveLanguage, value);
  }

  final _pets = "_pets";

  get pets {
    return _pref?.getInt(_pets) ?? -1;
  }

  set pets(value) {
    _pref?.setInt(_pets, value);
  }

  final _alcoholConsumption = "_alcoholConsumption";

  get alcoholConsumption {
    return _pref?.getInt(_alcoholConsumption) ?? -1;
  }

  set alcoholConsumption(value) {
    _pref?.setInt(_alcoholConsumption, value);
  }

  final _smoke = "_smoke";

  get smoke {
    return _pref?.getInt(_smoke) ?? -1;
  }

  set smoke(value) {
    _pref?.setInt(_smoke, value);
  }

  final _exercise = "_exercise";

  get exercise {
    return _pref?.getInt(_exercise) ?? -1;
  }

  set exercise(value) {
    _pref?.setInt(_exercise, value);
  }

  final _dietaryHabit = "_dietaryHabit";

  get dietaryHabit {
    return _pref?.getInt(_dietaryHabit) ?? -1;
  }

  set dietaryHabit(value) {
    _pref?.setInt(_dietaryHabit, value);
  }

  final _sleepHabits = "_sleepHabits";

  get sleepHabits {
    return _pref?.getInt(_sleepHabits) ?? -1;
  }

  set sleepHabits(value) {
    _pref?.setInt(_sleepHabits, value);
  }
}
