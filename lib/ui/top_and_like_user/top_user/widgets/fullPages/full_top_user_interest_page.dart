import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/ui/top_and_like_user/top_user/widgets/top_user_card.dart';
import 'package:chat_app/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';


class FullTopUserInterestPage extends StatefulWidget {
  const FullTopUserInterestPage({
    super.key,
    required this.listUser
  });
  final List<UserEntity> listUser;

  @override
  State<FullTopUserInterestPage> createState() => _FullTopUserInterestPageState();
}

class _FullTopUserInterestPageState extends State<FullTopUserInterestPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
          context: context,
          text: S().topUserSameHobbiesTitle,
          center: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(S().topUserSameHobbiesContent,
                style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),),

            const SizedBox(height: 10,),

            GridView.builder(
              itemCount: widget.listUser.length,
              shrinkWrap: true,
              addAutomaticKeepAlives: false,
              physics: const ScrollPhysics(),
              padding: const EdgeInsets.all(8),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 260),
              itemBuilder: (context, index) {
                UserEntity user = widget.listUser[index];
                return TopUserCard(
                  user: user,
                  isRecent: false,
                );
              },
            ),

          ],
        ),
      ),

    );
  }

}