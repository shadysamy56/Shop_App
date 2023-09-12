// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/modules/social_app/social_login/cubit/logincubit.dart';
import 'package:to_do_list/modules/social_app/social_login/cubit/loginstates.dart';
import 'package:to_do_list/modules/social_app/social_register/social_register_screen.dart';
import 'package:to_do_list/shared/components/components.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {},
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                        // SocialLoginCubit.get(context).userLogin(
                                        //   email: emailController.text,
                                        //   password: passwordController.text,
                                        // );
                                      }
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
