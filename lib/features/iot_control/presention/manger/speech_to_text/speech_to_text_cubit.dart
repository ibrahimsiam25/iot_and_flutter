import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
part 'speech_to_text_state.dart';


class SpeechToTextCubit extends Cubit<SpeechToTextState> {
  late stt.SpeechToText _speechToText;

  SpeechToTextCubit() : super(SpeechInitial()) {
    _initSpeechToText();
  }

  Future<void> _initSpeechToText() async {
    _speechToText = stt.SpeechToText();
    bool available = await _speechToText.initialize();
    if (available) {
      emit(SpeechAvailable());
    } else {
      emit(SpeechError(errorMessage: "Speech recognition not available"));
    }
  }

  void startListening() async {
    _speechToText.listen(onResult: (result) async {
      emit(SpeechListening(result.recognizedWords));
      if (result.finalResult) {
        emit(SpeechRecognized(result.recognizedWords));
        await Future.delayed(Duration(seconds: 1));
        print("data--------------------------${result.recognizedWords}");
        emit(SpeechAvailable()); // Reset state after listening is finished
      }
    });
  }

  void stopListening() {
    _speechToText.stop();
    emit(SpeechAvailable());
  }
}
