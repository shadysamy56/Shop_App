// ignore_for_file: prefer_const_constructors , prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/modules/social_app/social_login/social_login_screen.dart';
import 'package:to_do_list/modules/social_app/social_register/cubit/registercubit.dart';
import 'package:to_do_list/modules/social_app/social_register/cubit/registerstates.dart';
import 'package:to_do_list/shared/components/components.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialUserCreateSuccessState) {
            showToast(
                text: 'Registeration Successfully', state: ToastStates.SUCCESS);
            navigateAndfinish(context, SocialLoginScreen());
          }
          if (state is SocialUserCreateErrorState) {
            showToast(text: 'Registeration Failed', state: ToastStates.ERROR);
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
                          radius: 50.0,
                          backgroundImage: AssetImage('images/logo.png'),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
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
                          'Register to communicate with world',
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
                          suffix: SocialRegisterCubit.get(context).suffix,
                          suffixPressed: (() {
                            SocialRegisterCubit.get(context)
                                .changePasswordVisibility();
                          }),
                          isPassword:
                              SocialRegisterCubit.get(context).isPassword,
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
                        state is SocialRegisterLoadingState
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
                                      SocialRegisterCubit.get(context)
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
