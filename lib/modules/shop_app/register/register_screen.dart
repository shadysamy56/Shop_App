// ignore_for_file: prefer_const_constructors , prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_list/layout/shop_app/shop_layout.dart';
import 'package:to_do_list/modules/shop_app/register/cubit/registercubit.dart';
import 'package:to_do_list/modules/shop_app/register/cubit/registerstates.dart';
import 'package:to_do_list/shared/components/components.dart';
import 'package:to_do_list/shared/components/constants.dart';
import 'package:to_do_list/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel!.status ?? false) {
              print(state.loginModel!.status);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel!.data!.token,
              ).then((value) => {
                    token = state.loginModel!.data!.token,
                    navigateAndfinish(
                      context,
                      ShopLayout(),
                    ),
                  });
            } else {
              print(state.loginModel!.status);
              Fluttertoast.showToast(
                  msg: (state.loginModel!.message).toString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 20.0);
            }
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Register to see our hot offers',
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
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'User Name',
                          prefix: Icons.person,
                          validate: 'Please enter your name',
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
                          suffix: ShopRegisterCubit.get(context).suffix,
                          suffixPressed: (() {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          }),
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormfield(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          prefix: Icons.phone,
                          validate: 'Please enter your phone number',
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        state is ShopRegisterLoadingState
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
                                      ShopRegisterCubit.get(context)
                                          .userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                  child: Text(
                                    'REGISTER',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
