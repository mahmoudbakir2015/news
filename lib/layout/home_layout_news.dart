import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/search/search.dart';
import 'package:news/shared/componnents/componnents.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

class HomeLayoutNews extends StatelessWidget {
  const HomeLayoutNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubitNews, AppNewsStates>(
      listener: (BuildContext context, AppNewsStates state) {},
      builder: (BuildContext context, AppNewsStates state) {
        AppCubitNews cubit = AppCubitNews.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titlePage[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(
                    context: context,
                    widget: const SearchView(),
                  );
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                onPressed: () {
                  cubit.changeMode();
                },
                icon: const Icon(
                  Icons.brightness_4_outlined,
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changePage(index: index);
            },
            currentIndex: cubit.currentIndex,
            items: cubit.bottomNavItem,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
