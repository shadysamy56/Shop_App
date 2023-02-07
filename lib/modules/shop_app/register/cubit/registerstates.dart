// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import
import 'package:to_do_list/models/shop_app/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopLoginModel? loginModel;
  ShopRegisterSuccessState({this.loginModel});
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterPasswordVisibilityState extends ShopRegisterStates {}
