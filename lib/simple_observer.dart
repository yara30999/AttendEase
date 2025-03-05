import 'dart:developer';
import 'package:bloc/bloc.dart';

class SimpleObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('on change :$change');
  }

  @override
  void onClose(BlocBase bloc) {
    log('on close :$bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    log('on create :$bloc');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {}

  @override
  void onEvent(Bloc bloc, Object? event) {}

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('on Transition :$transition');
  }
}
