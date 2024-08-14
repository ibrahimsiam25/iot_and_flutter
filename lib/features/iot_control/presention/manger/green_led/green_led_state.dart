part of 'green_led_cubit.dart';

@immutable
sealed class GreenLedState {}

final class GreenLedInitial extends GreenLedState {}

final class GreenLedLoading extends GreenLedState {}

final class GreenLedSuccess extends GreenLedState {
  final bool greenLed;

  GreenLedSuccess({required this.greenLed});
}

final class RedLedIFailure extends GreenLedState {}
