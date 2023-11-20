// ignore_for_file: avoid_print, unused_element, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/modules/social_app/social_login/cubit/loginstates.dart';
import 'package:to_do_list/shared/components/components.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(SocialLoginSuccessState(value.user!.uid));
      showToast(text: 'Login Sucessfully', state: ToastStates.SUCCESS);
      print(value.user!.email);
      print(value.user!.uid);
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
      showToast(text: 'Failed to Login', state: ToastStates.ERROR);
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    isPassword = !isPassword;

    emit(SocialLoginPasswordVisibilityState());
  }
}
