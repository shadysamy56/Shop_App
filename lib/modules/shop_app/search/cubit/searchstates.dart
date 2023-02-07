// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import

abstract class ShopSearchStates {}

class ShopSearchInitialState extends ShopSearchStates {}

class ShopSearchLoadingState extends ShopSearchStates {}

class ShopSearchSuccessState extends ShopSearchStates {}

class ShopSearchErrorState extends ShopSearchStates {
  final String error;
  ShopSearchErrorState(this.error);
}
