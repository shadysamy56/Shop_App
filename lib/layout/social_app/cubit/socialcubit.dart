// ignore_for_file: avoid_print, prefer_const_constructors, unused_import

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_list/layout/social_app/cubit/socialstates.dart';
import 'package:to_do_list/models/social_app/social_post_model.dart';
import 'package:to_do_list/models/social_app/social_user_model.dart';
import 'package:to_do_list/modules/social_app/social_chats/social_chats_screen.dart';
import 'package:to_do_list/modules/social_app/social_feeds/social_feeds_screen.dart';
import 'package:to_do_list/modules/social_app/social_login/social_login_screen.dart';
import 'package:to_do_list/modules/social_app/social_newpost/social_newpost_screen.dart';
import 'package:to_do_list/modules/social_app/social_settings/social_settings_screen.dart';
import 'package:to_do_list/modules/social_app/social_users/social_users_screen.dart';
import 'package:to_do_list/shared/components/components.dart';
import 'package:to_do_list/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitailState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      emit(SocialGetUserSuccessState());
      showToast(text: 'Updated Sucessfully', state: ToastStates.SUCCESS);
      userModel = SocialUserModel.fromJson(value.data()!);
    }).catchError((error) {
      emit(SocialGetUserErrorState(error));
      showToast(text: 'Failed to Update', state: ToastStates.ERROR);
    });
  }

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    SocialFeedsScreen(),
    SocialChatsScreen(),
    SocialNewPostScreen(),
    SocialUsersScreen(),
    SocialSettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottom(index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required name,
    required phone,
    required bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required name,
    required phone,
    required bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    required name,
    required phone,
    required bio,
    String? image,
    String? cover,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      uId: userModel!.uId,
      email: userModel!.email,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? newPostImage;

  Future<void> getNewPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      newPostImage = File(pickedFile.path);
      emit(SocialNewPostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialNewPostImagePickedErrorState());
    }
  }

  void uploadNewPostImage({
    required dateTime,
    required postText,
  }) {
    emit(SocialCreateNewPostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(newPostImage!.path).pathSegments.last}')
        .putFile(newPostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createNewPost(
          dateTime: dateTime,
          postImage: value,
          postText: postText,
        );
      }).catchError((error) {
        emit(SocialCreateNewPostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreateNewPostErrorState());
    });
  }

  void createNewPost({
    required dateTime,
    required postText,
    String? postImage,
  }) {
    emit(SocialCreateNewPostLoadingState());

    SocialPostModel model = SocialPostModel(
      name: userModel?.name ?? '',
      uId: userModel?.uId ?? '',
      image: userModel?.image ?? '',
      dateTime: dateTime,
      postImage: postImage ?? '',
      postText: postText,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreateNewPostSuccessState());
    }).catchError((error) {
      emit(SocialCreateNewPostErrorState());
    });
  }

  void removeNewPostImage() {
    newPostImage = null;
    emit(SocialRemoveNewPostImageState());
  }

  List<SocialPostModel> posts = [];
  List<String> postsID = [];
  List<int> likes = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach(
        (element) {
          element.reference.collection('likes').get().then((value) {
            likes.add(value.docs.length);
            posts.add(SocialPostModel.fromJson(element.data()));
            postsID.add(element.id);
          });

          // posts.add(SocialPostModel.fromJson(element.data()));
          // postsID.add(element.id);
        },
      );
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postID) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('likes')
        .doc(userModel?.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  Future<void> userLogout(context) async {
    await FirebaseAuth.instance.signOut();
    // FirebaseAuth.instance.userChanges().listen((User? user) {
    //   if (user == null) {
    //     print('User is currently signed out!');
    //   } else {
    //     print('User is signed in!');
    //   }
    // });

    navigateAndfinish(context, SocialLoginScreen());
    showToast(text: 'Logout Sucessfully', state: ToastStates.SUCCESS);

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User is currently signed out!');
    }
    print(user!.uid);
  }
}
