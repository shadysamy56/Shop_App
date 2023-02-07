// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import
import 'package:to_do_list/models/shop_app/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel? loginModel;
  ShopLoginSuccessState({this.loginModel});
}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopLoginPasswordVisibilityState extends ShopLoginStates {}
