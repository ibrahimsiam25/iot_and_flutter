part of 'iot_control_cubit.dart';

@immutable
sealed class IotControlState {}

final class IotControlInitial extends IotControlState {}
final class IotControlLoading extends IotControlState {}

final class IotControlSuccess extends IotControlState {
  final SpeechToText _speechToText;
 final bool _hasSpeech  ;
 final String _lastWords ;

  IotControlSuccess({required SpeechToText speechToText, required bool hasSpeech, required String lastWords}) : _speechToText = speechToText, _hasSpeech = hasSpeech, _lastWords = lastWords;
}

final class IotControlIFailure extends IotControlState {}
