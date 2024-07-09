import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/ui/update_profile/update_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/generated/l10n.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  List<String> mFluentLanguageList = [];
  late UpdateProfileCubit _cubit;
  List<String> filteredLanguageList = [];

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<UpdateProfileCubit>(context);
    mFluentLanguageList.addAll(_cubit.state.fluentLanguageList!);
    filteredLanguageList.addAll(HelpersDataUser.languageList());
  }

  void search(String key) {
    if (key.isNotEmpty) {
      setState(() {
        filteredLanguageList = HelpersDataUser.languageList()
            .where((e) => e.toLowerCase().contains(key.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        filteredLanguageList.clear;
        filteredLanguageList = HelpersDataUser.languageList();
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
                      BlocProvider.of<UpdateProfileCubit>(context).updateState(
                          state.copyWith(
                              fluentLanguageList: mFluentLanguageList));
                      await BlocProvider.of<UpdateProfileCubit>(context)
                          .updateProfile();
                    },
                    child: Text(
                      S().languageDialogDoneText,
                      style: const TextStyle(
                          color: Color.fromRGBO(229, 58, 69, 1),
                          fontSize: 16,
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
                        S().languageDialogTitle,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      )),
                  Expanded(
                      flex: 1,
                      child: Text(
                        "${mFluentLanguageList.length} ${S().languageDialogOutOfText}",
                        textAlign: TextAlign.center,
                      ))
                ],
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
                  // controller: state.searchLanguageController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                    border: InputBorder.none,
                    hintText: S().languageDialogSearchText,
                  ),
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      fontSize: 16,
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
                      filteredLanguageList.length,
                      (index) {
                        final item = filteredLanguageList[index];
                        final isSelected = mFluentLanguageList.contains(item);
                        return InkWell(
                          onTap: () {
                            mFluentLanguageList.length < 5
                                ? !isSelected
                                    ? setState(() =>
                                        mFluentLanguageList.add(item ?? ''))
                                    : setState(
                                        () => mFluentLanguageList.remove(item))
                                : isSelected
                                    ? setState(
                                        () => mFluentLanguageList.remove(item))
                                    : null;
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
                                item ?? '',
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
