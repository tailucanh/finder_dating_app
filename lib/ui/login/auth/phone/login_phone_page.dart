import 'package:chat_app/router/router.dart';
import 'package:chat_app/ui/login/auth/phone/login_phone_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../generated/l10n.dart';

import 'login_phone_cubit.dart';
import 'login_phone_state.dart';

class LoginPhonePage extends StatelessWidget {
  const LoginPhonePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginPhoneCubit(
            navigator: LoginPhoneNavigator(context: context));
      },
      child: const LoginPhoneChildPage(),
    );
  }
}

class LoginPhoneChildPage extends StatefulWidget {
  const LoginPhoneChildPage({super.key});

  @override
  State<LoginPhoneChildPage> createState() => _LoginPhoneChildPageState();
}

class _LoginPhoneChildPageState extends State<LoginPhoneChildPage> {
  late final LoginPhoneCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyWidget();
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<LoginPhoneCubit, LoginPhoneState>(
        builder: (context, loginPhone) => Scaffold(
              extendBody: true,
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(
                    Icons.west,
                    color: Colors.grey,
                    size: 30,
                  ),
                  onPressed: () {
                    context.goNamed(AppRoutes.login);
                  },
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          S().titleEnterPhoneNumber,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 35),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: IntlPhoneField(
                                  decoration: const InputDecoration(
                                    counterText: '',
                                  ),
                                  initialCountryCode: 'VN',
                                  onCountryChanged: (phone) {
                                    context
                                        .read<LoginPhoneCubit>()
                                        .onChangeCodeCountry(
                                            '+${phone.fullCountryCode.toString()}');
                                  },
                                )),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              flex: 4,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                cursorColor: const Color.fromRGBO(
                                  234,
                                  64,
                                  128,
                                  100,
                                ),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  hintText: S().hintTextPhone,
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.5),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(
                                          234,
                                          64,
                                          128,
                                          100,
                                        ),
                                        width: 2),
                                  ),
                                ),
                                onChanged: (value) {
                                  context
                                      .read<LoginPhoneCubit>()
                                      .onChangeNumberPhone(value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Visibility(
                          // visible: myProvider.isErrorText,
                          child: Text(
                            S().textErrorEnterPhone,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: S().contentNotificationPhoneLogin1,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: S().contentNotificationPhoneLogin2,
                                    style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
