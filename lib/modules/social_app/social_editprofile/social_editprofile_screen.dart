// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:to_do_list/layout/social_app/cubit/socialcubit.dart';
import 'package:to_do_list/layout/social_app/cubit/socialstates.dart';
import 'package:to_do_list/shared/components/components.dart';

class SocialEditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = SocialCubit.get(context).userModel;
          var profileImage = SocialCubit.get(context).profileImage;
          var coverImage = SocialCubit.get(context).coverImage;
          nameController.text = userModel?.name ?? 'User Name';
          phoneController.text = userModel?.phone ?? 'Phone Number';
          bioController.text = userModel?.bio ?? 'Write about yourself .';

          return Scaffold(
            appBar: AppBar(
              title: Text('Edit Profile'),
              titleSpacing: 5.0,
              actions: [
                TextButton(
                    onPressed: () {
                      SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                    },
                    child: Text(
                      'UPDATE INFO',
                      style: TextStyle(fontSize: 16.0),
                    )),
                SizedBox(
                  width: 15.0,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // if (state is SocialUserUpdateLoadingState)
                    //   LinearProgressIndicator(),
                    // if (state is SocialUserUpdateLoadingState)
                    //   SizedBox(
                    //     height: 10.0,
                    //   ),
                    Container(
                      height: 180.0,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                          image: coverImage == null
                                              ? NetworkImage(
                                                  userModel?.cover ??
                                                      'https://as2.ftcdn.net/v2/jpg/05/36/16/27/1000_F_536162702_BXNkyzVOv2qOa8Z4ltBd6hgpgNUIzWxf.jpg',
                                                )
                                              : FileImage(coverImage)
                                                  as ImageProvider,
                                          fit: BoxFit.cover)),
                                ),
                                IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getCoverImage();
                                    },
                                    icon: CircleAvatar(
                                        radius: 28.0,
                                        child: Icon(
                                          IconBroken.Camera,
                                          size: 26.0,
                                        ))),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 65,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(
                                          userModel?.image ??
                                              'https://t4.ftcdn.net/jpg/03/26/98/51/360_F_326985142_1aaKcEjMQW6ULp6oI9MYuv8lN9f8sFmj.jpg',
                                        )
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon: CircleAvatar(
                                      radius: 28.0,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 26.0,
                                      ))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    if (SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                      Row(
                        children: [
                          if (SocialCubit.get(context).profileImage != null)
                            Expanded(
                                child: Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  child: Text('Upload Profile'),
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is SocialUserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            )),
                          SizedBox(
                            width: 5.0,
                          ),
                          if (SocialCubit.get(context).coverImage != null)
                            Expanded(
                                child: Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  child: Text('Upload Cover'),
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is SocialUserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            )),
                        ],
                      ),
                    if (SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                      SizedBox(
                        height: 20.0,
                      ),
                    defaultFormfield(
                        controller: nameController,
                        type: TextInputType.name,
                        label: 'Name',
                        prefix: IconBroken.User,
                        validate: 'Name must not be empty'),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultFormfield(
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: 'Phone',
                        prefix: IconBroken.Call,
                        validate: 'Phone must not be empty'),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultFormfield(
                        controller: bioController,
                        type: TextInputType.name,
                        label: 'Bio',
                        prefix: IconBroken.Info_Circle,
                        validate: 'Bio must not be empty'),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
