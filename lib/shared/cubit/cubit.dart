

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit() : super (AppInitialState());

  static AppCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;

  List<BottomNavigationBarItem> bottomItems =
  [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'science',
    ),
  ];



  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    emit(AppBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness()
  {
    emit(AppGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'business',
        'apiKey':'774f3b0b848046a3a06cbce4f92295bd',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      //print(business[0]['title']);

      emit(AppGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports()
  {
    emit(AppGetSportsLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'sports',
        'apiKey':'774f3b0b848046a3a06cbce4f92295bd',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      sports = value.data['articles'];
      //print(business[0]['title']);

      emit(AppGetSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetSportsErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];
  void getScience()
  {
    emit(AppGetScienceLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'science',
        'apiKey':'774f3b0b848046a3a06cbce4f92295bd',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      science = value.data['articles'];
      //print(business[0]['title']);

      emit(AppGetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetScienceErrorState(error.toString()));
    });
  }


  List<dynamic> search = [];
  void getSearch(String value)
  {
    emit(AppGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q':'$value',
        'apiKey':'774f3b0b848046a3a06cbce4f92295bd',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      //print(business[0]['title']);

      emit(AppGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetSearchErrorState(error.toString()));
    });
  }



  bool isDark = false;
  void changeAppMode({bool? fromShared}){
    if(fromShared!=null)
    {
      isDark=fromShared;
    }else {
      isDark=!isDark;
      CacheHelper.putBool(key: 'isDark', value: isDark).then((value){
        emit(AppChangeModeState());
      });
    }


  }



}

class AppMainCubit extends Cubit<AppStates> {

  AppMainCubit() : super (AppInitialState());

  static AppMainCubit get(context) => BlocProvider.of(context);


}