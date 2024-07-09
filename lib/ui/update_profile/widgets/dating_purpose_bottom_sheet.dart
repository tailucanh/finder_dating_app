import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/ui/update_profile/update_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/generated/l10n.dart';

class DatingPurposeBottomSheet extends StatelessWidget {
  const DatingPurposeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - 300) / 2;
    final double itemWidth = size.width / 2;
    final double height = MediaQuery.of(context).size.height / 1.5;

    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
        builder: (context, state) => Stack(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                        S().datingPurposeDialogTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        S().datingPurposeDialogContent,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: height * 2 / 3,
                        child: GridView.count(
                          crossAxisCount: 3,
                          childAspectRatio: itemWidth / itemHeight,
                          children: List.generate(
                              HelpersDataUser.datingPurposeList()
                                  .length, (index) {
                            final item =
                                HelpersDataUser.datingPurposeList()[index];
                            return InkWell(
                              onTap: () async {
                                Navigator.pop(context);
                                BlocProvider.of<UpdateProfileCubit>(context)
                                    .updateState(
                                        state.copyWith(datingPurpose: index));
                                await BlocProvider.of<UpdateProfileCubit>(
                                        context)
                                    .updateProfile();

                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.all(2),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                                  border: Border.all(
                                    color:  index == state.datingPurpose
                                        ? const Color(0xFFE94057)
                                        : Theme.of(context).brightness == Brightness.light ? Colors.grey : Colors.grey.shade900,
                                    width:   index == state.datingPurpose ? 2: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      HelpersDataUser
                                          .emojiDatingPurposeList[index],
                                      width: 40,
                                      height: 40,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        item,
                                        style: const TextStyle(fontSize: 12),
                                        overflow: TextOverflow.fade,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]));
  }
}
