import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/business/business.dart';
import 'package:news/modules/sciences/sciences.dart';
import 'package:news/modules/sports/sports.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class AppCubitNews extends Cubit<AppNewsStates> {
  AppCubitNews() : super(AppInitialNewsStates());

  static AppCubitNews get(context) => BlocProvider.of(context);

  String apiKey = 'd8079f7c3c0848abbe8dc2eb2d82a8e1';
  int currentIndex = 0;
  bool lightMode = true;
  TextEditingController searchController = TextEditingController();

  List<Widget> screens = const [
    Business(),
    Sciences(),
    Sports(),
  ];

  List<String> titlePage = [
    "Business",
    "Sciences",
    "Sports",
  ];

  List<dynamic> business = [];
  List<dynamic> sciences = [];
  List<dynamic> sports = [];
  List<dynamic> search = [];

  List<BottomNavigationBarItem> bottomNavItem = const [
    BottomNavigationBarItem(
      label: 'Business',
      icon: Icon(Icons.business),
    ),
    BottomNavigationBarItem(
      label: 'Sciences',
      icon: Icon(Icons.science),
    ),
    BottomNavigationBarItem(
      label: 'Sports',
      icon: Icon(Icons.sports),
    ),
  ];

  /// Business
  Future<void> getBusiness() async {
    emit(AppNewsGetBusinessLoading());
    try {
      final value = await DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          // 'country': 'eg',
          'category': 'business',
          'apiKey': apiKey,
        },
      );
      business = value.data['articles'] ?? [];
      log("Business loaded: ${business.length}");
      emit(AppNewsGetBusinessSuccess());
    } catch (error) {
      log("Business error: $error");
      emit(AppNewsGetBusinessError(error.toString()));
    }
  }

  /// Sciences
  Future<void> getSciences() async {
    emit(AppNewsGetSciencesLoading());
    if (sciences.isEmpty) {
      try {
        final value = await DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            // 'country': 'eg',
            'category': 'science',
            'apiKey': apiKey,
          },
        );
        sciences = value.data['articles'] ?? [];
        log("Sciences loaded: ${sciences.length}");
        emit(AppNewsGetSciencesSuccess());
      } catch (error) {
        log("Sciences error: $error");
        emit(AppNewsGetSciencesError(error.toString()));
      }
    } else {
      emit(AppNewsGetSciencesSuccess());
    }
  }

  /// Sports
  Future<void> getSports() async {
    emit(AppNewsGetSportsLoading());
    if (sports.isEmpty) {
      try {
        final value = await DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            // 'country': 'eg',
            'category': 'sports',
            'apiKey': apiKey,
          },
        );
        sports = value.data['articles'] ?? [];
        log("Sports loaded: ${sports.length}");
        emit(AppNewsGetSportsSuccess());
      } catch (error) {
        log("Sports error: $error");
        emit(AppNewsGetSportsError(error.toString()));
      }
    } else {
      emit(AppNewsGetSportsSuccess());
    }
  }

  /// Search
  Future<void> getSearch(String value) async {
    emit(AppNewsGetSearchLoading());
    try {
      final response = await DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': value,
          'apiKey': apiKey,
        },
      );
      search = response.data['articles'] ?? [];
      log("Search results for '$value': ${search.length}");
      emit(AppNewsGetSearchSuccess());
    } catch (error) {
      log("Search error: $error");
      emit(AppNewsGetSearchError(error.toString()));
    }
  }

  /// Change Bottom Navigation Page
  void changePage({required int index}) {
    currentIndex = index;
    if (index == 1) {
      getSciences();
    } else if (index == 2) {
      getSports();
    }
    emit(AppBottomNavNewsStates());
  }

  /// Change Mode (Light/Dark)
  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      lightMode = fromShared;
    } else {
      lightMode = !lightMode;
      CacheHelper.putData(
        value: lightMode,
        key: 'isLight',
      ).then((_) {
        emit(AppNewsChangeMode());
      });
    }
  }

  /// Launch URL
  static Future<void> launchURLApp(
    String uri, {
    bool inApp = false,
  }) async {
    Uri url = Uri.parse(uri);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: inApp ? LaunchMode.inAppWebView : LaunchMode.externalApplication,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
        ),
      );
    } else {
      throw 'could not launch $uri';
    }
  }
}
