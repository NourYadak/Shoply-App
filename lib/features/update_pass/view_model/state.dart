

abstract class UpdatePassState {}

class UpdatePassInitState extends UpdatePassState {}

class UpdatePassLoadingState extends UpdatePassState {}

class UpdatePassErrorState extends UpdatePassState {
  final String errorMessage;

  UpdatePassErrorState({required this.errorMessage});
}

class UpdatePassSuccessState extends UpdatePassState {}

class UpdatePassVisibilityToggledState extends UpdatePassState {}