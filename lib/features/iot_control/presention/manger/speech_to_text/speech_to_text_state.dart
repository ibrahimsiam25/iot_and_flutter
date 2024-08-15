part of 'speech_to_text_cubit.dart';

@immutable
sealed class SpeechToTextState {}

final class SpeechInitial extends SpeechToTextState {}

final class SpeechAvailable  extends SpeechToTextState {}

final class SpeechListening extends SpeechToTextState {
   final String recognizedWords;

SpeechListening(this.recognizedWords);
}
class SpeechRecognized extends SpeechToTextState  {
  final String recognizedWords;

  SpeechRecognized(this.recognizedWords);
}

final class SpeechError extends SpeechToTextState {
  final String errorMessage;

  SpeechError({required this.errorMessage});
}
