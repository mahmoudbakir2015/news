abstract class AppNewsStates {}

class AppInitialNewsStates extends AppNewsStates {}

class AppBottomNavNewsStates extends AppNewsStates {}

class AppNewsGetBusinessSuccess extends AppNewsStates {}

class AppNewsGetBusinessLoading extends AppNewsStates {}

class AppNewsGetBusinessError extends AppNewsStates {
  final String error;
  AppNewsGetBusinessError(this.error);
}

class AppNewsGetSportsSuccess extends AppNewsStates {}

class AppNewsGetSportsLoading extends AppNewsStates {}

class AppNewsGetSportsError extends AppNewsStates {
  final String error;
  AppNewsGetSportsError(this.error);
}

class AppNewsGetSciencesSuccess extends AppNewsStates {}

class AppNewsGetSciencesLoading extends AppNewsStates {}

class AppNewsGetSciencesError extends AppNewsStates {
  final String error;
  AppNewsGetSciencesError(this.error);
}

class AppNewsChangeMode extends AppNewsStates {}

class AppNewsGetSearchSuccess extends AppNewsStates {}

class AppNewsGetSearchLoading extends AppNewsStates {}

class AppNewsGetSearchError extends AppNewsStates {
  final String error;
  AppNewsGetSearchError(this.error);
}
