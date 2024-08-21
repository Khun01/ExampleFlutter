import 'package:equatable/equatable.dart';

abstract class SplashScreenEvent extends Equatable {
  const SplashScreenEvent();

  @override
  List<Object> get props => [];
}

class StartAnimationEvent extends SplashScreenEvent {}

class NavigateToLandingPageEvent extends SplashScreenEvent {}
