import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'verify_otp_cubit.dart';

class VerifyOtpPage extends StatelessWidget {
  const VerifyOtpPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return VerifyOtpCubit();
      },
      child: const VerifyOtpChildPage(),
    );
  }
}

class VerifyOtpChildPage extends StatefulWidget {
  const VerifyOtpChildPage({super.key});

  @override
  State<VerifyOtpChildPage> createState() => _VerifyOtpChildPageState();
}

class _VerifyOtpChildPageState extends State<VerifyOtpChildPage> {
  late final VerifyOtpCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
        builder: (context, state) => Scaffold(
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
                    context.goNamed('');
                  },
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S().titleEnterOTP,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 35),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              children: [
                                Text(
                                  '0333333333',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                // Center(
                                //     child: context.watch<LoginPhoneProvider>().resend
                                //         ? resend(context)
                                //         : countDown(context)),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PinCodeTextField(
                                appContext: context,
                                cursorColor: const Color.fromRGBO(
                                  234,
                                  64,
                                  128,
                                  100,
                                ),
                                length: 6,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                pinTheme: PinTheme(
                                  borderWidth: 2,
                                  shape: PinCodeFieldShape.underline,
                                  borderRadius: BorderRadius.circular(10),
                                  inactiveColor: Colors.grey,
                                  selectedColor: const Color.fromRGBO(
                                    234,
                                    64,
                                    128,
                                    100,
                                  ),
                                ),
                                onChanged: (value) {}),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: false,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            S().textErrorOTP,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
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
