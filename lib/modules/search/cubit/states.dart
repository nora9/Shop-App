import 'package:shop_app/models/search_model.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {

 final SearchModel? model;

 SearchSuccessState(this.model);

}

class SearchErrorState extends SearchStates {}

class SearchFavoritesIconSuccessState extends SearchStates {}