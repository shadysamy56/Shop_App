// ignore_for_file: prefer_const_constructors, dead_code, sized_box_for_whitespace

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/layout/shop_app/cubit/shopcubit.dart';
import 'package:to_do_list/layout/shop_app/cubit/shopstates.dart';
import 'package:to_do_list/shared/components/components.dart';

class ShopFavouritesScreen extends StatelessWidget {
  const ShopFavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildListProduct(
                ShopCubit.get(context)
                    .favoritesModel!
                    .data!
                    .data[index]
                    .product,
                context),
            separatorBuilder: (context, index) => MySeparator(),
            itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
