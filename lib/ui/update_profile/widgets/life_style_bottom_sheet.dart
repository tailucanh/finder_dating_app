import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/ui/update_profile/update_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/generated/l10n.dart';

class LifeStyleBottomSheet extends StatefulWidget {
  const LifeStyleBottomSheet({super.key});

  @override
  State<LifeStyleBottomSheet> createState() => _LifeStyleBottomSheetState();
}

class _LifeStyleBottomSheetState extends State<LifeStyleBottomSheet> {
  late UpdateProfileCubit _cubit;
  double positionedHeight = 400;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<UpdateProfileCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      builder: (context, state) => Stack(children: [
        GestureDetector(
          onVerticalDragUpdate: (details) {
            double delta = details.primaryDelta!;
            if (delta < 0) {
              setState(() {
                positionedHeight = MediaQuery.of(context).size.height / 1.2;
              });
            } else {
              setState(() {
                positionedHeight = 400;
              });
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
            ),
            height: positionedHeight,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
            ),

            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 25, bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.clear,
                                size: 30,
                              )),
                          IconButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              await _cubit.updateProfile(
                                myPet: state.myPet,
                                drinkingStatus: state.drinkingStatus,
                                smokingStatus: state.smokingStatus,
                                sportsStatus: state.sportsStatus,
                                eatingStatus: state.eatingStatus,
                                socialNetworkStatus: state.socialNetworkStatus,
                                sleepingHabits: state.sleepingHabits,
                              );
                            },
                            icon: const Icon(
                              Icons.check_rounded,
                              color: Color.fromRGBO(229, 58, 69, 1),
                              size: 30,
                            ),
                          )
                        ],
                      ),
                      Text(
                        S().lifeStyleDialogTitle,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        S().lifeStyleDialogContent,
                        style: const TextStyle( fontSize: 14),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildPets(context),
                      _buildDrinkingStatus(context),
                      _buildSmokingStatus(context),
                      _buildSportStatus(context),
                      _buildEatingStatus(context),
                      _buildSocialNetworkStatus(context),
                      _buildSleepingHabits(context)

                    ],
                  ),

                ),

                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : Colors.black,
                        ),

                        child: const Icon(Icons.linear_scale, size: 35,))),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _titleLifeStyle({required IconData icon, required String title}){
    return  Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
      ],
    );
  }

  Widget _buildPets(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleLifeStyle(icon: Icons.pets_rounded,title: S().lifeStyleDialogPetText),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersDataUser.myPetList().length,
            (index) {
              final item = HelpersDataUser.myPetList()[index];
              return InkWell(
                onTap: () {
                  _cubit.updateState(_cubit.state.copyWith(myPet: index));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: index == _cubit.state.myPet ? 2 : 1,
                        color: index == _cubit.state.myPet
                            ? const Color.fromRGBO(234, 64, 128, 1)
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Divider(
          color: Colors.grey.shade700,
          height: 32,
        ),
      ],
    );
  }

  Widget _buildDrinkingStatus(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleLifeStyle(icon: Icons.wine_bar_rounded,title: S().lifeStyleDialogAlcoholText),

        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersDataUser.drinkingStatusList().length,
            (index) {
              final item =
                  HelpersDataUser.drinkingStatusList()[index];
              return InkWell(
                onTap: () {
                  _cubit.updateState(
                      _cubit.state.copyWith(drinkingStatus: index));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: index == _cubit.state.drinkingStatus ? 2 : 1,
                        color: index == _cubit.state.drinkingStatus
                            ? const Color.fromRGBO(234, 64, 128, 1)
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Divider(
          color: Colors.grey.shade700,
          height: 32,
        ),
      ],
    );
  }

  Widget _buildSmokingStatus(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleLifeStyle(icon: Icons.smoking_rooms_rounded,title: S().lifeStyleDialogSmokeText),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersDataUser.smokingStatusList().length,
            (index) {
              final item =
                  HelpersDataUser.smokingStatusList()[index];
              return InkWell(
                onTap: () {
                  _cubit
                      .updateState(_cubit.state.copyWith(smokingStatus: index));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: index == _cubit.state.smokingStatus ? 2 : 1,
                        color: index == _cubit.state.smokingStatus
                            ? const Color.fromRGBO(234, 64, 128, 1)
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Divider(
          color: Colors.grey.shade700,
          height: 32,
        ),
      ],
    );
  }

  Widget _buildSportStatus(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleLifeStyle(icon: Icons.fitness_center_rounded,title: S().lifeStyleDialogExerciseText),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersDataUser.sportsStatusList().length,
            (index) {
              final item =
                  HelpersDataUser.sportsStatusList()[index];
              return InkWell(
                onTap: () {
                  _cubit
                      .updateState(_cubit.state.copyWith(sportsStatus: index));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: index == _cubit.state.sportsStatus ? 2 : 1,
                        color: index == _cubit.state.sportsStatus
                            ? const Color.fromRGBO(234, 64, 128, 1)
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Divider(
          color: Colors.grey.shade700,
          height: 32,
        ),
      ],
    );
  }

  Widget _buildEatingStatus(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleLifeStyle(icon: Icons.local_pizza_rounded,title: S().lifeStyleDialogEatText),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersDataUser.eatingStatusList().length,
            (index) {
              final item =
                  HelpersDataUser.eatingStatusList()[index];
              return InkWell(
                onTap: () {
                  _cubit
                      .updateState(_cubit.state.copyWith(eatingStatus: index));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: index == _cubit.state.eatingStatus ? 2 : 1,
                        color: index == _cubit.state.eatingStatus
                            ? const Color.fromRGBO(
                                234,
                                64,
                                128,
                                1,
                              )
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Divider(
          color: Colors.grey.shade700,
          height: 32,
        ),
      ],
    );
  }

  Widget _buildSocialNetworkStatus(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleLifeStyle(icon: Icons.social_distance_rounded,title: S().lifeStyleDialogMediaText),

        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersDataUser.socialNetworkStatusList().length,
            (index) {
              final item = HelpersDataUser.socialNetworkStatusList()[index];

              return InkWell(
                onTap: () {
                  _cubit.updateState(
                      _cubit.state.copyWith(socialNetworkStatus: index));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width:
                            index == _cubit.state.socialNetworkStatus ? 2 : 1,
                        color: index == _cubit.state.socialNetworkStatus
                            ? const Color.fromRGBO(
                                234,
                                64,
                                128,
                                1,
                              )
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Divider(
          color: Colors.grey.shade700,
          height: 32,
        ),
      ],
    );
  }

  Widget _buildSleepingHabits(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleLifeStyle(icon: Icons.wb_twighlight,title: S().lifeStyleDialogSleepingText),

        const SizedBox(
          height: 16,
        ),
        Wrap(
          children: List.generate(
            HelpersDataUser.sleepingHabitsStatusList().length,
            (index) {
              final item = HelpersDataUser.sleepingHabitsStatusList()[index];
              return InkWell(
                onTap: () {
                  _cubit.updateState(
                      _cubit.state.copyWith(sleepingHabits: index));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: index == _cubit.state.sleepingHabits ? 2 : 1,
                        color: index == _cubit.state.sleepingHabits
                            ? const Color.fromRGBO(
                                234,
                                64,
                                128,
                                1,
                              )
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
   
      ],
    );
  }
}
