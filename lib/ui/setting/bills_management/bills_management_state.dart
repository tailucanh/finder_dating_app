part of 'bills_management_cubit.dart';

class BillsManagementState extends Equatable {
  final LoadStatus? loadStatus;
  final List<PayEntity>? billsList;
  final UserEntity? user;

  const BillsManagementState({
    this.loadStatus = LoadStatus.initial,
    this.billsList,
     this.user,
  });

  @override
  List<Object?> get props => [
        loadStatus,
        billsList,
       user,
      ];

  BillsManagementState copyWith({
    LoadStatus? loadStatus,
    List<PayEntity>? billsList,
    UserEntity? user,
  }) {
    return BillsManagementState(
      loadStatus: loadStatus ?? this.loadStatus,
      user: user ?? this.user,
      billsList: billsList ?? this.billsList,
    );
  }
}
