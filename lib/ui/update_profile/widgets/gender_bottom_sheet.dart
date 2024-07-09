import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/ui/update_profile/update_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/generated/l10n.dart';

class GenderBottomSheet extends StatelessWidget {
  const GenderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 1.7;
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
        builder: (context, state) => Stack(children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                height: height,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                  ),
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Colors.black,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        S().updateProfileGenderText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: height * 2 / 3,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                HelpersDataUser.genderList()
                                    .length,
                            itemBuilder: (context, index) {
                              final item = HelpersDataUser.genderList()[index];

                              return InkWell(
                                  onTap: () async {
                                    BlocProvider.of<UpdateProfileCubit>(context)
                                        .updateState(
                                            state.copyWith(gender: index));
                                    await BlocProvider.of<UpdateProfileCubit>(
                                            context)
                                        .updateProfile()
                                        .then((value) =>
                                            Navigator.of(context).pop());
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                        color:  Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                                        border: Border(
                                            bottom: index <
                                                    HelpersDataUser.genderList().length - 1
                                                ? BorderSide(
                                                    color: Colors.grey.shade400,
                                                    width: 1)
                                                : BorderSide.none)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        ),
                                        if (index == state.gender)
                                          const Icon(
                                            Icons.check_rounded,
                                            color: Color.fromRGBO(
                                                229, 58, 69, 1),
                                            size: 25,
                                          )
                                      ],
                                    ),
                                  ));
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ]));
  }
}
