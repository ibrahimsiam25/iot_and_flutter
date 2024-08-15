import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/functions/firebase.dart';
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
        await Future.delayed(const Duration(seconds: 1));
        controlByVoice(result.recognizedWords);
        emit(SpeechAvailable()); // Reset state after listening is finished
      }
    });
  }

  void stopListening() {
    _speechToText.stop();
    emit(SpeechAvailable());
  }

  void controlByVoice(String input) {
    String lowerCaseInput = input.toLowerCase();
    if (trueCondition(lowerCaseInput) && lowerCaseInput.contains('red')) {
      updateValue(true, "redLed");
    } else if (falseCondition(lowerCaseInput) &&
        lowerCaseInput.contains('red')) {
      updateValue(false, "redLed");
    } else if (trueCondition(lowerCaseInput) &&
        lowerCaseInput.contains('green')) {
      updateValue(true, "greenLed");
    } else if (falseCondition(lowerCaseInput) &&
        lowerCaseInput.contains('green')) {
      updateValue(false, "greenLed");
    } else if (trueCondition(lowerCaseInput) &&
        lowerCaseInput.contains('fan')) {
      updateValue(true, "fan");
    } else if (falseCondition(lowerCaseInput) &&
        lowerCaseInput.contains('fan')) {
      updateValue(false, "fan");
    } else if (trueCondition(lowerCaseInput) &&
        lowerCaseInput.contains('all light')) {
      updateValue(true, "greenLed");
      updateValue(true, "redLed");
    } else if (falseCondition(lowerCaseInput) &&
        lowerCaseInput.contains('all light')) {
      updateValue(false, "greenLed");
      updateValue(false, "redLed");
    } else if (trueCondition(lowerCaseInput) &&
        lowerCaseInput.contains("every")) {
      updateValue(true, "greenLed");
      updateValue(true, "redLed");
      updateValue(true, "fan");
    } else if (falseCondition(lowerCaseInput) &&
        lowerCaseInput.contains('every')) {
      updateValue(false, "greenLed");
      updateValue(false, "redLed");
      updateValue(false, "fan");
    }
  }

  bool falseCondition(String lowerCaseInput) =>
      (lowerCaseInput.contains('off') ||
          lowerCaseInput.contains('of') ||
          lowerCaseInput.contains('close') ||
          lowerCaseInput.contains('closed') ||
          lowerCaseInput.contains('stop') ||
          lowerCaseInput.contains('no'));

  bool trueCondition(String lowerCaseInput) => (lowerCaseInput.contains('on') ||
      lowerCaseInput.contains('open') ||
      lowerCaseInput.contains('opened') ||
      lowerCaseInput.contains('start') ||
      lowerCaseInput.contains('started') ||
      lowerCaseInput.contains('yes'));
}
