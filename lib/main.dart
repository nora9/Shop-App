import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'layout/cubit/cubit.dart';
import 'layout/shop_layout.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool? isDark ;
  if(isDark==null){
    isDark=false;
  }else{
    isDark = CacheHelper.getData(key: 'isDark');
  }
  token =CacheHelper.getData(key: 'token');
  print(token);
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  if(onBoarding != null)
  {
    if(token != null) widget = ShopLayout();
    else widget = LoginScreen();
  } else
  {
    widget = OnBoardingScreen();
  }

  //print(onBoarding);
  runApp(MyApp(isDark!, widget));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;
  final bool isDark;

  MyApp(this.isDark, this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
