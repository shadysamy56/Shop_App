// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/modules/shop_app/search/cubit/searchcubit.dart';
import 'package:to_do_list/modules/shop_app/search/cubit/searchstates.dart';
import 'package:to_do_list/shared/components/components.dart';

class ShopSearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Search must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Search',
                          prefixIcon: Icon(
                            Icons.search,
                          )),
                      onChanged: (value) {
                        ShopSearchCubit.get(context).search(value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (state is ShopSearchLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (state is ShopSearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildListProduct(
                          ShopSearchCubit.get(context).model!.data!.data[index],
                          context,
                          isOldPrice: false,
                        ),
                        separatorBuilder: (context, index) => MySeparator(),
                        itemCount: ShopSearchCubit.get(context)
                            .model!
                            .data!
                            .data
                            .length,
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
