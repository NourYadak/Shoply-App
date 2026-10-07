abstract class ForgotPassState {}

class ForgotPassInitialState extends ForgotPassState {}

class ForgotPassLoadingState extends ForgotPassState {}

class ForgotPassSuccessState extends ForgotPassState {
  final String message;

  ForgotPassSuccessState(this.message);
}

class ForgotPassErrorState extends ForgotPassState {
  final String message;

  ForgotPassErrorState(this.message);
}
