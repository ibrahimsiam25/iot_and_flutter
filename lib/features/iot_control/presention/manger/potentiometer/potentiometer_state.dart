part of 'potentiometer_cubit.dart';

@immutable
sealed class PotentiometerState {}

final class PotentiometerInitial extends PotentiometerState {}

final class PotentiometerLoading extends PotentiometerState {}

final class PotentiometerSuccess extends PotentiometerState {
  final int potentiometer;

  PotentiometerSuccess({required this.potentiometer});
}

final class RedLedIFailure extends PotentiometerState {}
