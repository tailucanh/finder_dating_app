import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/ui/update_profile/update_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/generated/l10n.dart';

class InterestBottomSheet extends StatefulWidget {
  const InterestBottomSheet({super.key});

  @override
  State<InterestBottomSheet> createState() => _InterestBottomSheetState();
}

class _InterestBottomSheetState extends State<InterestBottomSheet> {
  late UpdateProfileCubit _cubit;
  List<int> mInterestList = [];
  List<String> filteredInterestList = [];

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<UpdateProfileCubit>(context);
    mInterestList.addAll(_cubit.state.interestsList!);
    filteredInterestList = HelpersDataUser.interestsList();
  }

  void onItemPressed(int index) {
    final item = filteredInterestList[index];
    final isSelected = HelpersDataUser.getItemFromListIndex(
             filteredInterestList, _cubit.state.interestsList!)
        .contains(item);
    _cubit.state.interestsList!.length < 5
        ? !isSelected
            ? setState(() => mInterestList.add(index))
            : setState(() => mInterestList.remove(index))
        : isSelected
            ? setState(() => mInterestList.remove(index))
            : null;
    _cubit.updateState(_cubit.state.copyWith(interestsList: mInterestList));
  }

  void search(String key) {
    if (key.isNotEmpty) {
      setState(() {
        filteredInterestList = HelpersDataUser.interestsList()
            .where((e) => e.toLowerCase().contains(key.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        filteredInterestList.clear;
        filteredInterestList = HelpersDataUser.interestsList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 1.2;

    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      builder: (context, state) => Stack(children: [
        Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          height: height,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.black,
          ),
          child: Column(
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
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      await _cubit.updateProfile();
                    },
                    child: Text(
                      S().interestDialogDoneText,
                      style: const TextStyle(
                          color: Color.fromRGBO(229, 58, 69, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text(
                        S().interestDialogTitle,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      )),
                  Expanded(
                      flex: 1,
                      child: Text(
                        "${_cubit.state.interestsList!.length} ${S().interestDialogOutOfText}",
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
              if (_cubit.state.interestsList!.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    S().interestDialogContent,
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade300
                      : Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  onChanged: (value) {
                    search(value);
                  },
                  // controller: _cubit.state.searchInterestController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                    border: InputBorder.none,
                    hintText: S().interestDialogSearchText,
                  ),
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(children: [
                  Wrap(
                    children: List.generate(
                      filteredInterestList.length,
                      (index) {
                        final item = filteredInterestList[index];
                        final isSelected = HelpersDataUser.getItemFromListIndex(filteredInterestList, mInterestList)
                            .contains(item);
                        return InkWell(
                          onTap: () {
                            onItemPressed(index);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10, right: 10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  width: isSelected ? 2 : 1,
                                  color: isSelected
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
                ]),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
