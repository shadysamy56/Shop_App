// ignore_for_file: prefer_const_constructors, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/layout/shop_app/cubit/shopstates.dart';
import 'package:to_do_list/models/shop_app/categories_model.dart';
import 'package:to_do_list/models/shop_app/changefavorites_model.dart';
import 'package:to_do_list/models/shop_app/home_model.dart';
import 'package:to_do_list/models/shop_app/login_model.dart';
import 'package:to_do_list/modules/shop_app/categories/categories_screen.dart';
import 'package:to_do_list/modules/shop_app/favourites/favourites_screen.dart';
import 'package:to_do_list/modules/shop_app/products/products_screen.dart';
import 'package:to_do_list/modules/shop_app/settings/settings_screen.dart';
import 'package:to_do_list/shared/components/constants.dart';
import 'package:to_do_list/shared/network/end_points.dart';
import 'package:to_do_list/shared/network/remote/dio_helper.dart';
import 'package:to_do_list/models/shop_app/favorites_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitailState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ShopProductsScreen(),
    ShopCategoriesScreen(),
    ShopFavouritesScreen(),
    ShopSettingsScreen(),
  ];

  void changeBottom(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  ShopHomeModel? homeModel;
  Map<int?, bool?> favourites = {};

  void getHomeData() {
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = ShopHomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element) {
        favourites.addAll({element.id: element.inFavorites});
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error);
      emit(ShopErrorHomeDataState());
    });
  }

  ShopCategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: Get_Categories,
      token: token,
    ).then((value) {
      categoriesModel = ShopCategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error);
      emit(ShopErrorCategoriesState());
    });
  }

  ShopFavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = ShopFavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error);
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopChangeFavoritesModel? changefavoritesModel;

  void changeFavorites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changefavoritesModel = ShopChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!favoritesModel!.status!) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changefavoritesModel!));
    }).catchError((error) {
      print(error);
      favourites[productId] = !favourites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error);
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error);
      emit(ShopErrorUpdateUserState());
    });
  }
}
