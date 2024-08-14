part of 'fan_cubit.dart';

@immutable
sealed class FanState {}

final class FanInitial extends FanState {}

final class FanLoading extends FanState {}

final class FanSuccess extends FanState {
  final bool fan;

  FanSuccess({required this.fan});
}

final class RedLedIFailure extends FanState {}
