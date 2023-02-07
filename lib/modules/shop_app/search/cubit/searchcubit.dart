// ignore_for_file: avoid_print, unused_element, prefer_const_constructors

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/models/shop_app/search_model.dart';
import 'package:to_do_list/modules/shop_app/search/cubit/searchstates.dart';
import 'package:to_do_list/shared/components/constants.dart';
import 'package:to_do_list/shared/network/end_points.dart';
import 'package:to_do_list/shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopSearchInitialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  ShopSearchModel? model;

  void search(String text) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = ShopSearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopSearchErrorState(error.toString()));
    });
  }
}
