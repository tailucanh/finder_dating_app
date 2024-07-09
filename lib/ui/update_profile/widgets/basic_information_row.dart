import 'package:chat_app/ui/update_profile/update_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'basic_information_bottom_sheet.dart';

class BasicInformationRow extends StatelessWidget {
  const BasicInformationRow({
    super.key,
    required this.title,
    this.content,
    required this.iconData,
    required this.cubit,
  });

  final UpdateProfileCubit cubit;
  final String title;
  final String? content;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: true,
          useSafeArea: true,
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          context: context,
          builder: (context) {
            return BlocProvider<UpdateProfileCubit>.value(
                value: cubit, child: const BasicInformationBottomSheet());
          },
        ).whenComplete(() {});
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 8.0),
              width: MediaQuery.of(context).size.width / 2 - 8.0,
              child: Row(
                children: [
                  Icon(
                    iconData,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 8.0,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      content!.isNotEmpty ? content! : S().emptyText,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade700,
                    size: 12,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
