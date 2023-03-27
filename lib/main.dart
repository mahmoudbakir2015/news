import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/home_layout_news.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';
import 'package:news/shared/styles/themes.dart';
import 'shared/observer_block.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool? isLight = await CacheHelper.getData(key: 'isLight');
  DioHelper.init();
  runApp(
    MyApp(isLight ?? true),
  );
}

class MyApp extends StatelessWidget {
  final bool isLight;
  const MyApp(this.isLight, {super.key});

  @override
  build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubitNews()
        ..changeMode(
          fromShared: isLight,
        )
        ..getBusiness(),
      child: BlocConsumer<AppCubitNews, AppNewsStates>(
          listener: (BuildContext context, AppNewsStates state) {},
          builder: (BuildContext context, AppNewsStates state) {
            AppCubitNews cubit = AppCubitNews.get(context);
            return MaterialApp(
              themeMode: cubit.lightMode ? ThemeMode.light : ThemeMode.dark,
              theme: lightTheme,
              darkTheme: darkTheme,
              debugShowCheckedModeBanner: false,
              home: const HomeLayoutNews(),
            );
          }),
    );
  }
}
