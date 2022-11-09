// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class UserLoginStateBase {}

class UserLoginLoading extends UserLoginStateBase {}

class UserLoginError extends UserLoginStateBase {
  final String message;

  UserLoginError({
    required this.message,
  });
}

class UserLoginSuccess extends UserLoginStateBase {
  final String userID;

  UserLoginSuccess(this.userID);
}
