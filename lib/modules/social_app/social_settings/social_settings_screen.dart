// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_local_variable, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:to_do_list/layout/social_app/cubit/socialcubit.dart';
import 'package:to_do_list/layout/social_app/cubit/socialstates.dart';
import 'package:to_do_list/modules/social_app/social_editprofile/social_editprofile_screen.dart';
import 'package:to_do_list/shared/components/components.dart';
import 'package:to_do_list/shared/styles/colors.dart';

class SocialSettingsScreen extends StatelessWidget {
  const SocialSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 180.0,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    userModel?.cover ??
                                        'https://as2.ftcdn.net/v2/jpg/05/36/16/27/1000_F_536162702_BXNkyzVOv2qOa8Z4ltBd6hgpgNUIzWxf.jpg',
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      CircleAvatar(
                        radius: 65,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage(
                            userModel?.image ??
                                'https://t4.ftcdn.net/jpg/03/26/98/51/360_F_326985142_1aaKcEjMQW6ULp6oI9MYuv8lN9f8sFmj.jpg',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  userModel?.name ?? 'User Name',
                  //userModel!.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  userModel?.bio ?? 'Write about yourself .',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '69',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '120',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '680',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '128',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'Following',
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              'Add Photo',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            ))),
                    SizedBox(
                      width: 10.0,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        navigateTo(context, SocialEditProfileScreen());
                      },
                      child: Icon(
                        IconBroken.Edit_Square,
                        color: Colors.black,
                        size: 18.0,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: 100.0,
                  height: 50.0,
                  color: defaultColor,
                  child: TextButton(
                    onPressed: () {
                      SocialCubit.get(context).userLogout(context);
                    },
                    child: Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
