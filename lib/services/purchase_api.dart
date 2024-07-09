
import 'package:flutter/services.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi{

  static const _apikey = 'goog_KgRYzTmcntpjlacTNZOiagUDdWQ';

  static Future init() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(_apikey);

  }


  static Future<List<Offering>> fetchOffers() async {
    try{
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;

      return current  == null ? [] :  [current];

    }on PlatformException catch (e){
      return [];
    }

  }

  static Future<bool> purchasesPackage(Package package) async {
    try{
      await Purchases.purchasePackage(package);
      return true;
    }on PlatformException catch (e){
      return false;
    }

  }



}