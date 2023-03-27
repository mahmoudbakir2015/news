import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/componnents/componnents.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';


class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubitNews, AppNewsStates>(
      listener: (BuildContext context, AppNewsStates state) {},
      builder: (BuildContext context, AppNewsStates state) {
        AppCubitNews cubit = AppCubitNews.get(context);
        var list = cubit.search;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(
              20,
            ),
            child: Column(
              children: [
                defaultTextForm(
                  label: 'Search',
                  controller: cubit.searchController,
                  textInputType: TextInputType.text,
                  iconData: Icons.search,
                  onValidate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Search must not be empty';
                    }
                    return null;
                  },
                  onChange: (value) {
                    cubit.getSearch(value);
                  },
                ),
                Expanded(
                  child: articleBuilder(
                    list,
                    isSearch: true,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
