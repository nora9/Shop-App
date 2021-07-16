import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/ends_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);
      //print(model!.data!.data[0].name);

      emit(SearchSuccessState(model));
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }


  void goTrue(Product model, String text){
    model.inFavorites=! model.inFavorites!;
    search(text);
    //emit(SearchFavoritesIconSuccessState());
  }
}