
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InternetState{lost ,gain ,initial}

class InternetCubit extends Cubit<InternetState>{
   final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;

InternetCubit():super(InternetState.initial){


  connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
    debugPrint("Run.......");
    debugPrint("Run.......$result");
 if(result.first == ConnectivityResult.mobile || result.first == ConnectivityResult.wifi ){
   emit(InternetState.gain);
 }else{
   emit(InternetState.lost);
 }
  }, );
}

@override
  Future<void> close() {
  connectivitySubscription?.cancel();
  return super.close();
  }

}