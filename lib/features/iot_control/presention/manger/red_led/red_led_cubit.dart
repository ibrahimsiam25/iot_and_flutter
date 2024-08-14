import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iot_and_flutter/core/functions/firebase.dart';

part 'red_led_state.dart';

class RedLedCubit extends Cubit<RedLedState> {
  RedLedCubit(this.usersStream) : super(RedLedInitial()) {
    usersStream.listen((snapshot) {
      emitStateBasedOnFirebaseChanges(snapshot);
    });
  }
  final Stream<QuerySnapshot> usersStream;
  late bool redLed;
  void emitStateBasedOnFirebaseChanges(QuerySnapshot<Object?> snapshot) {
    for (var docChange in snapshot.docChanges) {
      if (docChange.type == DocumentChangeType.modified) {
        var data = docChange.doc.data() as Map<String, dynamic>?;
        switch (docChange.doc.id) {
          case "redLed":
            redLed = data!['value'];
            emit(RedLedSuccess(redLed: redLed));
            break;
        }
        print(
            "data--------------------------${docChange.doc.id}----- ${data!['value']}");
      }
    }
  }

  
  void fetchData() async {
    emit(RedLedLoading());
  redLed = await fetchDataFromFirebase( "redLed");
       emit(RedLedSuccess(redLed: redLed));
  }


}
