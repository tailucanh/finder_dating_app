import 'package:chat_app/app/app_config.dart';
import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/model/entities/pay_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:chat_app/services/purchase_api.dart';
import 'package:chat_app/ui/payment/payment_navigater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:uuid/uuid.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({required this.navigator}) : super(const PaymentState());
  final PaymentNavigator navigator;
  final userRepository = getIt<UserRepository>();

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      final isPrimary = await userRepository.getPrimaryAcceleration();
      emit(state.copyWith(
          loadDataStatus: LoadStatus.success,
          isPrimaryAcceleration: isPrimary));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<void> setPaymentInfo({required double price,required int turn,required int priority}) async {
    emit(state.copyWith(totalPrice: price, turn: turn, priority: priority));
  }


  Future<void> fetchOffers() async {
    final offerings = await PurchaseApi.fetchOffers();
    if(offerings.isEmpty){
      print("No Plans Found");
    }else {
      final packages = offerings.map((offer) => offer.availablePackages).expand((pair) => pair).toList();
      print(packages);
      emit(state.copyWith(listPackages: packages));
    }
  }

  Future<void> paymentGooglePlay({required String total, required int turn, required int priority})async{
    final user = await userRepository.getUserProfile();
    await userRepository.createBill(
        payEntity: PayEntity(
            id: Uuid().v1(),
            email: user.email,
            name: user.fullName,
            address: user.currentAddress,
            amount: total,
            payee:'GooglePlay',
            description: 'Payment transactions via Google Play',
            createTime: DateTime.now().toUtc().toString(),
            currency: '',
            payment_mode: '',
            typePay: 'GooglePlay'
        ));
    await userRepository
        .createAccelerate(turn: turn, priority: priority)
        .then((value) async {
      final isPrimary = await userRepository.getPrimaryAcceleration();
      emit(state.copyWith(isPrimaryAcceleration: isPrimary));
    });
  }





  Future<void> paymentPaypal(BuildContext context,
      {required String total, required int turn, required int priority}) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => PaypalCheckoutView(
          sandboxMode: true,
          clientId: AppConfig.clientID,
          secretKey: AppConfig.secretKey,
          transactions: [
            {
              "amount": {
                "total": total,
                "currency": "USD",
                "details": {
                  "subtotal": total,
                  "shipping": '0',
                  "shipping_discount": 0
                }
              },
              "description": "The payment transaction description.",
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            await userRepository.createBill(
                payEntity: PayEntity(
              id: params['data']['id'],
              email: params['data']['payer']['payer_info']['email'],
              name: params['data']['payer']['payer_info']['shipping_address']
                  ['recipient_name'],
              address: params['data']['payer']['payer_info']['shipping_address']
                  ['city'],
              amount: params['data']['transactions'][0]['amount']['total'],
              payee: params['data']['transactions'][0]['payee']['email'],
              description: params['data']['transactions'][0]['description'],
              createTime: params['data']['create_time'],
              currency: params['data']['transactions'][0]['amount']['currency'],
              payment_mode: params['data']['transactions'][0]['related_resources'][0]['sale']['payment_mode'],
              typePay: 'Paypal'
            ));
            await userRepository
                .createAccelerate(turn: turn, priority: priority)
                .then((value) async {
              Navigator.pop(context);
              final isPrimary = await userRepository.getPrimaryAcceleration();
              emit(state.copyWith(isPrimaryAcceleration: isPrimary));
            });
          },
          onError: (error) {
            Navigator.pop(context);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      ));
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
