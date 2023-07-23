import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Modules/social_app/login/login_screen.dart';
import 'Shared/bloc_observer.dart';
import 'Shared/components/constans.dart';
import 'Shared/cubit/cubit/app_cubit.dart';
import 'Shared/cubit/states/states.dart';
import 'Shared/network/local/cache_helper.dart';
import 'Shared/network/remote/dio_helper.dart';
import 'Shared/styles/themes.dart';
import 'layout/social_app/cubit/cubit.dart';
import 'layout/social_app/social_layout.dart';

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  uId = CacheHelper.getData(key: 'uId');

  Widget? widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');
  print(token);

  // if(onBoarding != null)
  // {
  //   if(token!= null) widget = ShopLayout();
  //   else widget = ShopLoginScreen();
  // } else
  // {
  //   widget = OnBoardingScreen();
  // }

  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  // constructor
  // build
  final bool? isDark;
  final Widget? startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });
  // final shopCubit = ShopCubit(
  //   dioHelper: DioHelper(),
  //   cacheHelper: CacheHelper(),
  // );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark ?? false,
            ),
        ),
        // BlocProvider(
        //   create: (BuildContext context) => shopCubit..getHomeData()..getCategories()..getUserData(),
        // ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
