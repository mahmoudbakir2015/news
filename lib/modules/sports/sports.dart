import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/componnents/componnents.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';


class Sports extends StatelessWidget {
  const Sports({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubitNews, AppNewsStates>(
        listener: (BuildContext context, AppNewsStates state) {},
        builder: (BuildContext context, AppNewsStates state) {
          var list = AppCubitNews.get(context).sports;
          return articleBuilder(list);
        });
  }
}
