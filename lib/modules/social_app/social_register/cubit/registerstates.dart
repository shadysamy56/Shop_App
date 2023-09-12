// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import
import 'package:to_do_list/models/shop_app/login_model.dart';

abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;
  SocialRegisterErrorState(this.error);
}

class SocialRegisterPasswordVisibilityState extends SocialRegisterStates {}
