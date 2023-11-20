// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:to_do_list/layout/social_app/cubit/socialcubit.dart';
import 'package:to_do_list/layout/social_app/cubit/socialstates.dart';
import 'package:to_do_list/modules/social_app/social_feeds/social_feeds_screen.dart';
import 'package:to_do_list/shared/components/components.dart';
import 'package:to_do_list/shared/styles/colors.dart';

class SocialNewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialCreateNewPostSuccessState) {
          showToast(
              text: 'Post Uploaded Successfully', state: ToastStates.SUCCESS);
          navigateAndfinish(context, SocialFeedsScreen());
        }
        if (state is SocialCreateNewPostErrorState) {
          showToast(text: 'Post Uploaded Failed', state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  IconBroken.Arrow___Left_2,
                )),
            title: Text('Create Post'),
            actions: [
              TextButton(
                  onPressed: () {
                    if (SocialCubit.get(context).newPostImage == null) {
                      SocialCubit.get(context).createNewPost(
                        dateTime: now.toString(),
                        postText: textController.text,
                      );
                    } else {
                      SocialCubit.get(context).uploadNewPostImage(
                        dateTime: now.toString(),
                        postText: textController.text,
                      );
                    }
                    SocialCubit.get(context).getPosts();
                  },
                  child: Text('POST'))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreateNewPostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreateNewPostLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel?.image}'),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${SocialCubit.get(context).userModel?.name}',
                                style: TextStyle(height: 1.3),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: defaultColor,
                                size: 16.0,
                              )
                            ],
                          ),
                          Text(
                            'Public',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(height: 1.3),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                if (SocialCubit.get(context).newPostImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                image: FileImage(
                                    SocialCubit.get(context).newPostImage!),
                                fit: BoxFit.cover)),
                      ),
                      IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removeNewPostImage();
                          },
                          icon: CircleAvatar(
                              radius: 28.0,
                              child: Icon(
                                Icons.close,
                                size: 26.0,
                              ))),
                    ],
                  ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getNewPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(width: 5.0),
                              Text('Add Photo')
                            ],
                          )),
                    ),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: Text('# Tags'))),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
