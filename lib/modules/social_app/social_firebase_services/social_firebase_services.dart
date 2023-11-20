// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:to_do_list/modules/social_app/social_login/cubit/loginstates.dart';
// import 'package:to_do_list/modules/social_app/social_login/social_login_screen.dart';
// import 'package:to_do_list/shared/components/components.dart';


// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// class FirebaseService {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final FirebaseDatabase _database = FirebaseDatabase.instance;

//   void userLogin({
//     required String email,
//     required String password,
//   }) {
//     emit(SocialLoginLoadingState());

//     _firebaseAuth
//         .signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     )
//         .then((value) {
//       emit(SocialLoginSuccessState(value.user!.uid));
//       showToast(text: 'Login Sucessfully', state: ToastStates.SUCCESS);
//       print(value.user!.email);
//       print(value.user!.uid);
//     }).catchError((error) {
//       emit(SocialLoginErrorState(error.toString()));
//       showToast(text: 'Failed to Login', state: ToastStates.ERROR);
//     });
//   }

//   Future<void> userLogout(context) async {
//     await FirebaseAuth.instance.signOut();
//     FirebaseAuth.instance.userChanges().listen((User? user) {
//       if (user == null) {
//         print('User is currently signed out!');
//       } else {
//         print('User is signed in!');
//       }
//     });
//     navigateAndfinish(context, SocialLoginScreen());
//     showToast(text: 'Logout Sucessfully', state: ToastStates.SUCCESS);
//   }
// }
