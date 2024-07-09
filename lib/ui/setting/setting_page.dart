import 'dart:math';
import 'package:chat_app/app/app_color.dart';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/ui/setting/setting_cubit.dart';
import 'package:chat_app/ui/setting_query/setting_query_cubit.dart';
import 'package:chat_app/ui/setting_query/widgets/widget_basic_search.dart';
import 'package:chat_app/ui/widgets/app_bar.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app/app_setting/app_setting_cubit.dart';
import '../../model/Language.dart';
import '../../services/package_info .dart';
import '../widgets/popup_notification.dart';
import 'widgets/card_custom.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SettingCubit();
      },
      child: const SettingChildPage(),
    );
  }
}

class SettingChildPage extends StatefulWidget {
  const SettingChildPage({super.key});

  @override
  State<SettingChildPage> createState() => _SettingChildPageState();
}

class _SettingChildPageState extends State<SettingChildPage> {
  late final AppSettingCubit _cubit;
  late final SettingCubit _cubitSetting;
  bool _isExpandedLanguage = false;
  bool _isExpandedTheme = false;
  late ConfettiController  _confettiController;
  late OverlayEntry _overlayEntry;
  static const String URL_GOOGLE_PLAY = 'https://play.google.com/store/account/subscriptions';

  void _openSubscriptionPage() async {
    final Uri _url = Uri.parse(URL_GOOGLE_PLAY);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }


  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(milliseconds: 800));
    _cubit = BlocProvider.of<AppSettingCubit>(context);
    _cubitSetting = BlocProvider.of<SettingCubit>(context);
    _cubitSetting.loadInitialData();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingCubit, AppSettingState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if(_isExpandedLanguage){
              setState(() {
                _isExpandedLanguage = false;
                 _isExpandedTheme = false;
              });
            }
            return true;
          },
          child: Scaffold(
            appBar: PrimaryAppBar(
              context: context,
              text: S.current.settingPageSubTitleAppBar,
            ),
            body: SafeArea(
                child: _buildBodyWidget(_cubit),
              ),
          ),
        );
      },
    );
  }

  Widget _buildBodyWidget(AppSettingCubit cubit) {
    Size size = MediaQuery.of(context).size;
    final appLocal = S.of(context);
    final currentLocal =  Localizations.localeOf(context);
    Language? currentLanguage = Language.languageList().firstWhere(
          (language) => language.languageCode == currentLocal.languageCode,
      orElse: () => Language(0, "", "Unknown", ""),
    );
    return Container(
      decoration: BoxDecoration(
        color: cubit.state.themeMode == ThemeMode.dark
            ? AppColors.black700
            : Colors.grey.shade200,
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 40),
            child: InkWell(
              onTap: (){
                setState(() {
                  _isExpandedLanguage = false;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildPremiumOptions(context,cubit, appLocal, size),
                  // _buildAdvertisement(),
                  _buildTitle(
                      title: appLocal.settingPageSearchText,
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                      appLocal: appLocal),
                  BlocProvider(
                    create: (context) => SettingQueryCubit(),
                    child: const BasicSearchWidget(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    child: Text(S().settingLocationContent, style: TextStyle(fontSize: 14,color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade700
                        : Colors.grey.shade300),),
                  ),
                  _buildTitle(
                      padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 10.0),
                      title: appLocal.settingThemeTitle,
                      appLocal: appLocal),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isExpandedTheme = !_isExpandedTheme;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                            decoration: BoxDecoration(
                                color: _cubit.state.themeMode == ThemeMode.light
                                    ? Colors.white
                                    : Colors.black,

                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(!_isExpandedTheme ? 10 : 0),
                                    bottomRight: Radius.circular(!_isExpandedTheme ? 10 : 0),
                                )),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _cubit.state.themeMode == ThemeMode.light ?  S().settingThemeLight : S().settingThemeDark,
                                  style: TextStyle(
                                      fontSize: 16.sp, fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  !_isExpandedTheme
                                      ? Icons.keyboard_arrow_right_rounded
                                      : Icons.keyboard_arrow_down_outlined,
                                  size: 25,
                                  color: Colors.grey.shade600,
                                ),
                              ],
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            height: _isExpandedTheme ? 80 : 0.0,
                            curve: Curves.easeInOut,
                            child: _isExpandedTheme
                                ? Container(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: HelpersDataUser.listThemeModeTitle().length,
                                  itemBuilder: (context, index) {
                                    String item = HelpersDataUser.listThemeModeTitle()[index];
                                    BorderRadius borderRadius = (index == HelpersDataUser.listThemeModeTitle().length - 1)
                                        ? const BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))
                                        : BorderRadius.circular(0);
                                    return InkWell(
                                      onTap: () async {
                                        setState(() {
                                          _isExpandedTheme = !_isExpandedTheme;
                                          _cubit.changeMode(themeMode: HelpersDataUser.listThemeMode()[index]);
                                        });

                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        decoration: BoxDecoration(
                                            borderRadius: borderRadius,
                                          color: _cubit.state.themeMode == ThemeMode.light
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item,
                                              style:
                                              const TextStyle(fontSize: 14),
                                            ),
                                            (index == 0 &&  _cubit.state.themeMode == ThemeMode.light)
                                                ? const Icon(
                                              Icons.check_rounded,
                                              size: 20,
                                              color: Colors.red,
                                            ) : (index == 1 &&  _cubit.state.themeMode == ThemeMode.dark )? const Icon(
                                              Icons.check_rounded,
                                              size: 20,
                                              color: Colors.red): const SizedBox(),

                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            )
                                : const SizedBox(),
                          ),
                          const SizedBox(height: 8,),
                          Text(S().settingThemeContent, style: TextStyle(fontSize: 14,color: Theme.of(context).brightness == Brightness.light
                              ? Colors.grey.shade700
                              : Colors.grey.shade300),)

                        ],
                      ),
                    ),
                  ),

                  _buildTitle(
                      padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 10.0),
                      title: appLocal.payAccountManagementTitle,
                      appLocal: appLocal),
                  _buildBillManagementSetting(appLocal, currentLanguage),

                  _buildTitle(
                      padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 10.0),
                      title: appLocal.settingPageChangeLanguageText,
                      appLocal: appLocal),


                  _buildLanguageSetting(appLocal,currentLanguage),

                  _buildTitle(
                      padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 10.0),
                      title: appLocal.settingCommunity,
                      appLocal: appLocal),
                  _buildSettingCommunity(),
                  _buildSettingPrivacy(),

                    InkWell(
                      onTap: () async {
                        final box = context.findRenderObject() as RenderBox?;
                        await Share.share('Download the app and experience it! \n https://play.google.com/store/apps/details?id=com.polyvn.chat_app',
                            sharePositionOrigin:
                            box!.localToGlobal(Offset.zero) & box.size);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10.0),
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                        decoration: BoxDecoration(
                            color: _cubit.state.themeMode == ThemeMode.light
                                ? Colors.white
                                : Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(appLocal.setting_share_finder,style: TextStyle(
                            fontSize: 15,fontWeight: FontWeight.w600
                        ),
                        ),
                      ),
                    ),
                  BlocBuilder<SettingCubit, SettingState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: ()  {
                            AppPopupNotification.showDialogComplete(context, content:'${S().setting_time_active_content_1} ${HelpersDataUser.convertSeconds(state.tokenUser?.time ?? 0)} ${S().setting_time_active_content_2}',
                                onSubmit: () {
                                   Navigator.pop(context);
                                   _hideOverlay();
                                   _confettiController.stop();
                            });
                            _confettiController.play();
                          _showOverlay(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10.0),
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                          decoration: BoxDecoration(
                              color: _cubit.state.themeMode == ThemeMode.light
                                  ? Colors.white
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(appLocal.setting_time_active, style: TextStyle(
                              fontSize: 15,fontWeight: FontWeight.w600
                          ),
                          ),
                        ),
                      );
                    },
                  ),
               // _isShowActiveTime ? _showOverlay(context) : overlayEntry.remove(),

                  _buildLogoutButton(appLocal),


                  const SizedBox(height: 40,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'ic_tinder_logo'.withImage(),
                        width: 50,
                      ),
                    ],
                  ),

                  FutureBuilder<String?>(
                    future: getAppInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text('${S().textVersionApp} ${snapshot.data ?? ""}',style: const TextStyle(color: Colors.grey), textAlign: TextAlign.center, );
                      }
                    },
                  ),
                  const SizedBox(height: 40,),
                ],
              ),
            ),
          ),
          _isExpandedLanguage ? AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            color: Colors.black.withOpacity(0.4),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            curve: Curves.linear,
            child: Container(
              margin: const EdgeInsets.only(left: 80),
              child: Stack(
                children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),

                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                  color: cubit.state.themeMode == ThemeMode.dark ? Colors.black : Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:  const EdgeInsets.only(top: 25.0,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'ic_tinder_logo'.withImage(),
                              width: 35.w,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ShaderMask(
                                shaderCallback: (bounds) => const LinearGradient(colors: [
                                  Color(0xFFd73730),
                                  Color(0xFFee0979),
                                ]).createShader(bounds),
                                child: Text(
                                  'Finder',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28.sp,
                                      fontFamily: "Kanit",
                                      fontWeight: FontWeight.w800),
                                )),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: Language.languageList().length,
                            itemBuilder: (context, index) {
                              Language item = Language.languageList()[index];
                              return InkWell(
                                onTap: ()  async {
                                  await _cubit.saveSetting(locale: Locale(item.languageCode ?? 'en'));
                                  setState(() {
                                    _isExpandedLanguage = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(top: 15,left: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.flag,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(width: 8,),
                                      Text(item.name,
                                        style: TextStyle(fontSize: 17 ,fontWeight: item.name == currentLanguage.name ? FontWeight.w600 : FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),

                    ],
                  ),
                ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        _isExpandedLanguage = false;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color.fromRGBO(234, 64, 128, 1), Color.fromRGBO(238, 128, 95, 1)],
                        ),
                      ),
                      child:  Transform.rotate(
                          angle: -90 * pi / 180,
                          child: Image.asset('arrow-down'.withIconPNG())),
                    ),
                  ),

                ],
              ),
            ),
          ) : const SizedBox.shrink(),

        ],
      ),
    );
  }

  Widget _buildTitle(
      {required String title,
      required EdgeInsets padding,
      required S appLocal}) {
    return Padding(
      padding: padding,
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 17),
      ),
    );
  }

  void _showOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 2,
            emissionFrequency: 0.2,
            numberOfParticles: 20,
            blastDirectionality: BlastDirectionality.explosive,
          ),
        ),
      ),
    );

   Overlay.of(context)!.insert(_overlayEntry);
  }
  void _hideOverlay() {
    _overlayEntry.remove();
  }


  Widget _buildPremiumOptions(BuildContext context, AppSettingCubit cubit, S appLocal, Size size) {
    return Column(
      children: [
        CardSettingCustom(
            onTap: () {},
            cubit: cubit,
            assetsIcon: 'ic_tinder_logo'.withImage(),
            assetsBanner: 'tinder-platinum-banner'.withIcon(),
            subTitle: appLocal.settingPageSubTitle1,
            width: size.width / 1,
            isHaveIcon: false),
        CardSettingCustom(
            onTap: () {},
            cubit: cubit,
            assetsIcon: 'ic_tinder_logo'.withImage(),
            assetsBanner:'tinder-gold-banner'.withIcon(),
            subTitle: appLocal.settingPageSubTitle2,
            width: size.width / 1,
            isHaveIcon: false),
        CardSettingCustom(
          onTap: () {},
          cubit: cubit,
          assetsIcon: 'ic_tinder_logo'.withImage(),
          assetsBanner: 'tinder-plus-banner'.withIcon(),
          subTitle: appLocal.settingPageSubTitle3,
          width: size.width / 1,
          isHaveIcon: false,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CardSettingCustom(
              onTap: () {},
              cubit: cubit,
              subTitle: appLocal.settingPageTitle1,
              isHaveIcon: true,
              iconData: Icons.star,
              iconColor: Colors.blue,
              width: size.width / 2.3,
              title: '',
            ),
            CardSettingCustom(
              onTap: () => context.goNamed('home-highlight-page'),
              cubit: cubit,
              subTitle: appLocal.settingPageSubTitle5,
              isHaveIcon: true,
              iconData: Icons.bolt,
              iconColor: Colors.purple,
              width: size.width / 2.3,
              title: '',
            ),
          ],
        ),
        CardSettingCustom(
          subTitle: appLocal.settingPageSubTitle6,
          title: '',
          cubit: cubit,
          isHaveIcon: true,
          iconData: Icons.visibility_off_outlined,
          iconColor: Colors.grey.shade600,
          onTap: () {},
          width: size.width / 1,
        ),
      ],
    );
  }

  Widget _buildBillManagementSetting(S appLocal, Language currentLanguage) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10.0),
      padding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
      decoration: BoxDecoration(
          color: _cubit.state.themeMode == ThemeMode.light
              ? Colors.white
              : Colors.black,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              context.goNamed(AppRoutes.paymentAccountPage);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 15,top: 5,bottom: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(appLocal.paymentAccountTitle,style: TextStyle(
                    fontSize: 16,fontWeight: FontWeight.w400
                  ),
                  ),
                  Icon(Icons.keyboard_arrow_right_rounded, size: 25)
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 1,
          ),
          InkWell(
            onTap: () async {
              _openSubscriptionPage();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 15,top: 10,bottom: 10,left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(appLocal.paymentGooglePlayTitle,style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w400
                  ),
                  ),
                  Icon(Icons.keyboard_arrow_right_rounded, size: 25)
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 1,
          ),
          InkWell(
            onTap: () {
             context.goNamed(AppRoutes.billManagement);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 15,top: 10,bottom: 5,left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(appLocal.billManagementTitle,style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w400
                  ),
                  ),
                  Icon(Icons.keyboard_arrow_right_rounded, size: 25)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCommunity(){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15.0),
      decoration: BoxDecoration(
          color: _cubit.state.themeMode == ThemeMode.light
              ? Colors.white
              : Colors.black,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              print('Setting');
            },
            child: Row(
              children: [
                Text(S().settingCommunity_Content_1, style: TextStyle( fontSize: 15,fontWeight: FontWeight.w500),),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          InkWell(
            onTap: (){
              print('Setting');
            },
            child: Row(
              children: [
                Text(S().settingCommunity_Content_2, style: TextStyle( fontSize: 15,fontWeight: FontWeight.w500),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingPrivacy(){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15.0),
      decoration: BoxDecoration(
          color: _cubit.state.themeMode == ThemeMode.light
              ? Colors.white
              : Colors.black,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(
              padding: const EdgeInsets.only(bottom: 10.0),
              title: S().settingPrivacy,
              appLocal: S()),
          InkWell(
            onTap: (){
              print('Setting');
            },
            child: Row(
              children: [
                Text(S().settingCommunity_Content_1, style: TextStyle( fontSize: 15,fontWeight: FontWeight.w500),),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          InkWell(
            onTap: (){
              print('Setting');
            },
            child: Row(
              children: [
                Text(S().settingCommunity_Content_2, style: TextStyle( fontSize: 15,fontWeight: FontWeight.w500),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSetting(S appLocal, Language currentLanguage) {
    return InkWell(
      onTap: (){
        setState(() {
          _isExpandedLanguage = true;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60.h,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20.0),
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
        decoration: BoxDecoration(
            color: _cubit.state.themeMode == ThemeMode.light ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2.8,
              alignment: Alignment.centerLeft,
              child: Text(
                appLocal.settingPageLanguageCurrentText,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            Row(
              children:<Widget> [
                Text(currentLanguage.flag,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 5,),
                Text(currentLanguage.name, style: TextStyle(
                    color:  Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                    fontSize: 15
                ),),
                const SizedBox(width: 5,),
                const Icon(Icons.keyboard_arrow_right_outlined, size: 20,)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(S appLocal) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 25),
      decoration: BoxDecoration(
          color: _cubit.state.themeMode == ThemeMode.light ? Colors.white : Colors.black,
          borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
          onPressed: () async {
            AppPopupNotification.dialogExitApp(context: context, content: S().contentDialogExitApp, onExit: () =>    _cubit.logout(context));
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: Colors.transparent,
          ),
          child: Text(
            appLocal.settingPageLogOutText,
            style:  TextStyle(
                color: _cubit.state.themeMode == ThemeMode.light ? Colors.black : Colors.white,
                fontSize: 17, fontWeight: FontWeight.w500),
          )),
    );
  }

}
