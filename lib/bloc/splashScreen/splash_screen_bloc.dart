import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_screen_event.dart';
import 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenInitial());

  Stream<SplashScreenState> mapEventToState(SplashScreenEvent event) async* {
    if (event is StartAnimationEvent) {
      yield AnimationStarted();
      await Future.delayed(const Duration(seconds: 5));
      yield NavigationReady();
    } else if (event is NavigateToLandingPageEvent) {
      
    }
  }
}
