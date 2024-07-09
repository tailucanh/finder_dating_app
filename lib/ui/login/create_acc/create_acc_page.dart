import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/ui/login/create_acc/widgets/add_birthday_page.dart';
import 'package:chat_app/ui/login/create_acc/widgets/add_dating_purpose_page.dart';
import 'package:chat_app/ui/login/create_acc/widgets/add_gender_page.dart';
import 'package:chat_app/ui/login/create_acc/widgets/add_interests_list_page.dart';
import 'package:chat_app/ui/login/create_acc/widgets/add_name_page.dart';
import 'package:chat_app/ui/login/create_acc/widgets/add_photos_list_page.dart';
import 'package:chat_app/ui/login/create_acc/widgets/add_request_to_show_page.dart';
import 'package:chat_app/ui/login/create_acc/widgets/rules_page.dart';
import 'package:chat_app/ui/widgets/popup_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../router/router.dart';
import 'create_acc_cubit.dart';
import 'create_acc_navigator.dart';

class CreateAccPage extends StatelessWidget {
  const CreateAccPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CreateAccCubit(
          navigator: CreateAccNavigator(context: context),
        );
      },
      child: CreateAccChildPage(
          authentication: ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>),
    );
  }
}

class CreateAccChildPage extends StatefulWidget {
  const CreateAccChildPage({super.key, required this.authentication});

  final Map<String, dynamic> authentication;

  @override
  State<CreateAccChildPage> createState() => _CreateAccChildPageState();
}

class _CreateAccChildPageState extends State<CreateAccChildPage> {
  late final CreateAccCubit _cubit;
  late final PageController pageController;
  final time = const Duration(milliseconds: 100);
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
    );

    nameController =
        TextEditingController(text: widget.authentication['fullName']);
    _cubit = BlocProvider.of(context);
  }

  void _onCancelCreateAccount() {
    AppPopupNotification.dialogExitApp(
        context: context,
        content: S.current.contentDialogExitRegister,
        onExit: () async {
          _cubit.authRepository
              .logoutGoogle(
                  accessToken: widget.authentication['accessToken'],
                  idToken: widget.authentication['idToken'])
              .then((value) => GoRouter.of(context)
                  .pushReplacementNamed(AppRoutes.onBoarding));
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (pageController.page! > 0) {
          pageController.previousPage(
              duration: time, curve: Curves.bounceInOut);
          return false;
        } else {
          _onCancelCreateAccount();
          return true;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: _buildBodyWidget(),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Column(
      children: [
        BlocBuilder<CreateAccCubit, CreateAccState>(
          buildWhen: (previous, current) {
            return previous.indexPage != current.indexPage;
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                  child: LinearProgressIndicator(
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(234, 64, 128, 1)),
                    backgroundColor: Colors.grey.shade200,
                    value: (state.indexPage + 1) / 8,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: state.indexPage == 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: InkWell(
                            onTap: () => _onCancelCreateAccount(),
                            child: SvgPicture.asset('delete'.withIcon()),
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            pageController.previousPage(
                                duration: time, curve: Curves.bounceInOut);
                          },
                          icon: const Icon(
                            Icons.west,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                ),
              ],
            );
          },
        ),
        Expanded(
          child: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) async =>
                await _cubit.changePage(indexPage: value),
            children: [
              RulesPageSection(pageController: pageController),
              AddNamePageSection(
                  pageController: pageController,
                  textController: nameController),
              AddBirthdayPageSection(
                  cubit: _cubit, pageController: pageController),
              AddGenderPageSection(pageController: pageController),
              AddRequestToShowPageSection(pageController: pageController),
              AddDatingPurposePageSection(pageController: pageController),
              AddInterestsListPageSection(pageController: pageController),
              AddPhotoListPageSection(authentication: widget.authentication),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cubit.close();
    pageController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
