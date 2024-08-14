import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import '../../../../../core/functions/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


part 'green_led_state.dart';

class GreenLedCubit extends Cubit<GreenLedState> {
  GreenLedCubit(this.usersStream) : super(GreenLedInitial()) {
    usersStream.listen((snapshot) {
      emitStateBasedOnFirebaseChanges(snapshot);
    });
  }
  final Stream<QuerySnapshot> usersStream;
  late bool greenLed;
  void emitStateBasedOnFirebaseChanges(QuerySnapshot<Object?> snapshot) {
    for (var docChange in snapshot.docChanges) {
      if (docChange.type == DocumentChangeType.modified) {
        var data = docChange.doc.data() as Map<String, dynamic>?;
        switch (docChange.doc.id) {
          case "greenLed":
            greenLed = data!['value'];
            emit(GreenLedSuccess(greenLed: greenLed));
            break;
        }
        print(
            "data--------------------------${docChange.doc.id}----- ${data!['value']}");
      }
    }
  }

  void fetchData() async {
    emit(GreenLedLoading());
    greenLed = await fetchDataFromFirebase("greenLed");
     emit(GreenLedSuccess(greenLed: greenLed));
  }
}
