part of 'create_story_cubit.dart';

class CreateStoryState extends Equatable {
  final LoadStatus loadDataStatus;
  final bool success;

  const CreateStoryState(
      {this.loadDataStatus = LoadStatus.initial, this.success = false});

  @override
  List<Object?> get props => [loadDataStatus, success];

  CreateStoryState copyWith({
    LoadStatus? loadDataStatus,
    bool? success,
  }) {
    return CreateStoryState(
        loadDataStatus: loadDataStatus ?? this.loadDataStatus,
        success: success ?? this.success);
  }
}
