part of 'iot_control_cubit.dart';

@immutable
sealed class IotControlState {}

final class IotControlInitial extends IotControlState {}

final class IotControSuccess extends IotControlState {}

final class IotControlIFailure extends IotControlState {}
