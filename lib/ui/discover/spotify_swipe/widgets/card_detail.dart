import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'item_music_card.dart';

class CardDetail extends StatelessWidget {
  const CardDetail({super.key, this.userEntity, this.locationUser, required this.onTap});

  final UserEntity? userEntity;
  final Function onTap;
  final GeoPoint? locationUser;

  @override
  Widget build(BuildContext context) {
    GeoPoint? currentLocation;
    int distance = -1;
    if(helpersFunctions.userLatitude != 0){
      currentLocation = GeoPoint(helpersFunctions.userLatitude, helpersFunctions.userLongitude);
    }
    if(locationUser != null){
      distance = HelpersDataUser.calculateDistance(currentLocation!, locationUser!);
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 3,
            offset: const Offset(1, -1),
          ),
        ],
      ),
      child: ItemMusicCard(
        onTap: onTap,
        user: userEntity!,
        distance: distance,
      ),
    );
  }
}
