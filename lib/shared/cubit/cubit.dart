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
  AppCubitNews()
      : super(
          AppInitialNewsStates(),
        );

  static AppCubitNews get(context) => BlocProvider.of(context);

  String apiKey = 'c7888604ab814228a401b2bb923c8afa';
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
      icon: Icon(
        Icons.business,
      ),
    ),
    BottomNavigationBarItem(
      label: 'Sciences',
      icon: Icon(
        Icons.science,
      ),
    ),
    BottomNavigationBarItem(
      label: 'Sports',
      icon: Icon(
        Icons.sports,
      ),
    ),
  ];

  void getBusiness() {
    emit(
      AppNewsGetBusinessLoading(),
    );
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': apiKey,
      },
    ).then((value) {
      business = value.data['articles'];
      // print(business[0]['title']);
      emit(
        AppNewsGetBusinessSuccess(),
      );
    }).catchError((error) {
      // print(
      //   error.toString(),
      // );
      emit(
        AppNewsGetBusinessError(
          error.toString(),
        ),
      );
    });
  }

  void getSciences() {
    emit(
      AppNewsGetSciencesLoading(),
    );
    if (sciences.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': apiKey,
        },
      ).then((value) {
        sciences = value.data['articles'];
        // print(sciences[0]['title']);
        emit(
          AppNewsGetSciencesSuccess(),
        );
      }).catchError((error) {
        // print(
        //   error.toString(),
        // );
        emit(
          AppNewsGetSciencesError(
            error.toString(),
          ),
        );
      });
    } else {
      emit(
        AppNewsGetSciencesSuccess(),
      );
    }
  }

  void getSports() {
    emit(
      AppNewsGetSportsLoading(),
    );
    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': apiKey,
        },
      ).then((value) {
        sports = value.data['articles'];
        // print(sports[0]['title']);
        emit(
          AppNewsGetSportsSuccess(),
        );
      }).catchError((error) {
        // print(
        //   error.toString(),
        // );
        emit(
          AppNewsGetSportsError(
            error.toString(),
          ),
        );
      });
    } else {
      emit(
        AppNewsGetSportsSuccess(),
      );
    }
  }

  void getSearch(String value) {
    emit(
      AppNewsGetSearchLoading(),
    );
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': apiKey,
      },
    ).then((value) {
      search = value.data['articles'];
      // print(search[0]['title']);
      emit(
        AppNewsGetSearchSuccess(),
      );
    }).catchError((error) {
      // print(
      //   error.toString(),
      // );
      emit(
        AppNewsGetSearchError(
          error.toString(),
        ),
      );
    });
  }

  void changePage({
    required int index,
  }) {
    currentIndex = index;
    if (index == 1) {
      getSciences();
    } else if (index == 2) {
      getSports();
    }
    emit(
      AppBottomNavNewsStates(),
    );
  }

  void changeMode({
    bool? fromShared,
  }) {
    if (fromShared != null) {
      lightMode = fromShared;
    } else {
      lightMode = !lightMode;
      CacheHelper.putData(
        value: lightMode,
        key: 'isLight',
      ).then((value) async {
        // print(
        //   await CacheHelper.getData(key: 'isLight') as bool,
        // );
        emit(
          AppNewsChangeMode(),
        );
      });
    }
  }

  static Future<void> launchURLApp(
    String uri, {
    bool inApp = false,
  }) async {
    Uri url = Uri.parse(uri);
    if (await canLaunchUrl(url)) {
      // await launch(
      //   url.toString(),
      //   forceSafariVC: inApp,
      //   forceWebView: inApp,
      //   enableJavaScript: true,
      // );

      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
        ),
      );
    } else {
      throw 'could not launch $uri';
    }
  }
}
