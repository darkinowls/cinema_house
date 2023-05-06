import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity = Connectivity();
  static const networkList = [
    ConnectivityResult.ethernet,
    ConnectivityResult.wifi,
    ConnectivityResult.vpn,
    ConnectivityResult.mobile
  ];

  NetworkCubit() : super(NoNetwork()) {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (networkList.contains(result)) {
      emit(NetworkExists());
      return;
    }
    emit(NoNetwork());
  }

  Future<void> updateStatus() async {
    _updateConnectionStatus(await _connectivity.checkConnectivity());
  }
}
