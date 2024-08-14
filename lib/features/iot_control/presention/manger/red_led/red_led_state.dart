part of 'red_led_cubit.dart';

@immutable
sealed class RedLedState {}

final class RedLedInitial extends RedLedState {}

final class RedLedLoading extends RedLedState {}

final class RedLedSuccess extends RedLedState {
  final bool redLed;

  RedLedSuccess({required this.redLed});
}

final class RedLedIFailure extends RedLedState {}
