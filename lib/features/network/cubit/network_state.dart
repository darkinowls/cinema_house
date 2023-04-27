part of 'network_cubit.dart';

@immutable
abstract class NetworkState extends Equatable {
  @override
  List<Object> get props => [];
}

class NoNetwork extends NetworkState {}

class NetworkExists extends NetworkState {}
