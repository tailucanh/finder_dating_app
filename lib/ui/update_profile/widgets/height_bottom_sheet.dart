import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/ui/update_profile/update_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/generated/l10n.dart';

class HeightBottomSheet extends StatefulWidget {
  const HeightBottomSheet({super.key});


  @override
  State<HeightBottomSheet> createState() => _HeightBottomSheetState();
}

class _HeightBottomSheetState extends State<HeightBottomSheet> {
  late UpdateProfileCubit _cubit;
  late TextEditingController heightController;
  final FocusNode _focusNode = FocusNode();
  bool isError = false;


  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<UpdateProfileCubit>(context);
    heightController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    heightController.clear();
    _focusNode.unfocus();
  }

  Future<void> _onEditHeight() async {
    if( heightController.text.isNotEmpty &&  int.parse(heightController.text) >= 90 && int.parse(heightController.text) <= 245){
      setState(() {
        isError = false;
      });
      Navigator.pop(context);
      await _cubit
          .updateProfile(
        height: int.parse(heightController.text),
      );
      heightController.clear();
      _focusNode.unfocus();
    }else {
      setState(() {
        isError = true;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 1.5;

    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
        builder: (context, state) {
          if((state.height ?? 0) > 0){
            heightController.text = state.height.toString();
          }
          return  Container(
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.linear_scale, size: 35,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () async {
                            await _cubit
                                .getUserProfileFromRemote()
                                .then((value) => Navigator.of(context).pop());
                            heightController.clear();
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 30,
                          )),
                      IconButton(
                        onPressed: () async => _onEditHeight(),
                        icon: const Icon(
                          Icons.check_rounded,
                          color: Color.fromRGBO(229, 58, 69, 1),
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S().updateProfileUserHeightTitle,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    S().updateProfileUserHeightContent,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: TextField(
                      controller: heightController,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.number,
                      style: TextStyle( color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black : Colors.white, fontWeight: FontWeight.w500,fontSize: 16),

                      decoration: InputDecoration(
                          constraints: const BoxConstraints(
                            maxHeight: 45,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          hintText:'cm',
                          hintStyle: const TextStyle(color: Colors.grey,fontSize: 15),
                          focusedBorder:  OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).brightness == Brightness.light
                                    ? Colors.grey : Colors.grey.shade200,
                              ),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).brightness == Brightness.light
                                    ? Colors.grey : Colors.grey.shade200,
                              ),
                              borderRadius: BorderRadius.circular(8)
                          )
                      ),
                      onChanged: (value){
                        if(!HelpersDataUser.isInteger(value)){
                          heightController.clear();
                        }
                      },
                      onEditingComplete: () async => _onEditHeight(),
                    ),
                  ),
                  (isError) ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0,left: 5),
                        child: Text(S().updateProfileUserHeightError,maxLines: 1,style: const TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w500),),
                      ))
                      : const SizedBox(),


                  InkWell(
                    onTap: () async {
                      if((state.height ?? 0) > 0){
                        Navigator.pop(context);
                        await _cubit
                            .updateProfile(
                          height: 0,
                        );
                        heightController.clear();
                      }

                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                      decoration: BoxDecoration(
                        color: (state.height ?? 0) > 0 ? Colors.transparent : Colors.grey.shade300,
                        border: Border.all(color: Colors.grey,width: 2),
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Text(S().updateProfileUserHeightDelete, style: TextStyle(color:  Colors.grey.shade700,fontSize: 16,fontWeight: FontWeight.w600),),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      );
  }
}

