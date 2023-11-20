// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:to_do_list/layout/social_app/cubit/socialcubit.dart';
import 'package:to_do_list/layout/social_app/social_layout.dart';
import 'package:to_do_list/modules/social_app/social_login/cubit/logincubit.dart';
import 'package:to_do_list/modules/social_app/social_login/cubit/loginstates.dart';
import 'package:to_do_list/modules/social_app/social_register/social_register_screen.dart';
import 'package:to_do_list/shared/components/components.dart';
import 'package:to_do_list/shared/components/constants.dart';
import 'package:to_do_list/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // providers: [
      //   BlocProvider(create: (context) => SocialCubit()),
      //   BlocProvider(create: (context) => SocialLoginCubit()),
      // ],
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(
              text: state.error.toString(),
              state: ToastStates.ERROR,
            );
          }

          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) => {
                  // i have problem here , casting of uId ana 7alet el mawdo3 keda bas ana mesh 3aref leeh
                  // t2reban la2n uId lesa not equal uid so lama ba3mel restart kol beb2a tamam
                  uId = state.uId,
                  navigateAndfinish(context, SocialLayout()),
                });
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 80.0,
                            backgroundImage: AssetImage('images/logo.png'),
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Login to communicate with world',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          defaultFormfield(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email',
                            prefix: Icons.email_outlined,
                            validate: 'Please enter your email address',
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormfield(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            validate: 'Please enter your password',
                            suffix: SocialLoginCubit.get(context).suffix,
                            suffixPressed: (() {
                              SocialLoginCubit.get(context)
                                  .changePasswordVisibility();
                            }),
                            isPassword:
                                SocialLoginCubit.get(context).isPassword,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          state is SocialLoginLoadingState
                              ? Center(child: CircularProgressIndicator())
                              : Container(
                                  width: double.infinity,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        SocialLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                      //SocialCubit.get(context).getUserData();
                                    },
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account ?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, SocialRegisterScreen());
                                },
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
