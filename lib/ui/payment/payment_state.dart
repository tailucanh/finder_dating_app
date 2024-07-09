part of 'payment_cubit.dart';

class PaymentState extends Equatable {
  final LoadStatus loadDataStatus;
  final  bool isPrimaryAcceleration;
  final  double totalPrice;
  final  int turn;
  final  int priority;
  final  List<Package>? listPackages;

  const PaymentState({
    this.loadDataStatus = LoadStatus.initial,
    this.isPrimaryAcceleration = false,
    this.totalPrice = 0,
    this.turn = 0,
    this.priority = 0,
    this.listPackages,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        isPrimaryAcceleration,
        totalPrice,
        turn,
        priority,
        listPackages,
      ];

  PaymentState copyWith({
    LoadStatus? loadDataStatus,
    bool? isPrimaryAcceleration,
      double? totalPrice,
      int? turn,
      int? priority,
    List<Package>? listPackages,
  }) {
    return PaymentState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      isPrimaryAcceleration: isPrimaryAcceleration ?? this.isPrimaryAcceleration,
      totalPrice: totalPrice ?? this.totalPrice,
      turn: turn ?? this.turn,
      priority: priority ?? this.priority,
        listPackages: listPackages ?? this.listPackages,
    );
  }
}
