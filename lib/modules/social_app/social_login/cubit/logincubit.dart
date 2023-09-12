// ignore_for_file: avoid_print, unused_element, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/modules/social_app/social_login/cubit/loginstates.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  // void userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(SocialLoginLoadingState());

  //   DioHelper.postData(url: LOGIN, data: {
  //     'email': email,
  //     'password': password,
  //   }).then((value) {
  //     loginModel = SocialLoginModel.fromJson(value.data);
  //     emit(SocialLoginSuccessState(loginModel: loginModel));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(SocialLoginErrorState(error.toString()));
  //   });
  // }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    isPassword = !isPassword;

    emit(SocialLoginPasswordVisibilityState());
  }
}
