// ignore_for_file: avoid_print, unused_element, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/modules/social_app/social_register/cubit/registerstates.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  // void userRegister({
  //   required String name,
  //   required String email,
  //   required String password,
  //   required String phone,
  // }) {
  //   emit(SocialRegisterLoadingState());

  //   DioHelper.postData(
  //     url: REGISTER,
  //     data: {
  //       'name': name,
  //       'email': email,
  //       'password': password,
  //       'phone': phone,
  //     },
  //   ).then((value) {
  //     loginModel = SocialLoginModel.fromJson(value.data);
  //     emit(SocialRegisterSuccessState(loginModel: loginModel));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(SocialRegisterErrorState(error.toString()));
  //   });
  // }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    isPassword = !isPassword;

    emit(SocialRegisterPasswordVisibilityState());
  }
}
