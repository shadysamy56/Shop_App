// ignore_for_file: prefer_const_constructors , prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/layout/shop_app/cubit/shopcubit.dart';
import 'package:to_do_list/layout/shop_app/cubit/shopstates.dart';
import 'package:to_do_list/shared/components/components.dart';

class ShopSettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = ShopCubit.get(context).userModel!.data!.name!;
        emailController.text = ShopCubit.get(context).userModel!.data!.email!;
        phoneController.text = ShopCubit.get(context).userModel!.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      'Profile Information',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    if (state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormfield(
                        controller: nameController,
                        type: TextInputType.name,
                        label: 'name',
                        prefix: Icons.person,
                        validate: 'name must not be empty'),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormfield(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'email adress',
                        prefix: Icons.email,
                        validate: 'email must not be empty'),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormfield(
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: 'phone',
                        prefix: Icons.phone,
                        validate: 'phone must not be empty'),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        child: Text('Update')),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                        ),
                        onPressed: () {
                          signOut(context);
                        },
                        child: Text('Sign Out')),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

// TextButton(
//   onPressed: () {
//     signOut(context);
//   },
//   child: Text('Sign Out'),
// )
