import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import '../../../../../core/functions/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


part 'potentiometer_state.dart';

class PotentiometerCubit extends Cubit<PotentiometerState> {
  PotentiometerCubit(this.usersStream) : super(PotentiometerInitial()) {
    usersStream.listen((snapshot) {
      emitStateBasedOnFirebaseChanges(snapshot);
    });
  }
  final Stream<QuerySnapshot> usersStream;
  late int potentiometer;
  void emitStateBasedOnFirebaseChanges(QuerySnapshot<Object?> snapshot) {
    for (var docChange in snapshot.docChanges) {
      if (docChange.type == DocumentChangeType.modified) {
        var data = docChange.doc.data() as Map<String, dynamic>?;
        switch (docChange.doc.id) {
          case "potentiometer":
            potentiometer = data!['value'];
            emit(PotentiometerSuccess(potentiometer: potentiometer));
            break;
        }
        print(
            "data--------------------------${docChange.doc.id}----- ${data!['value']}");
      }
    }
  }

  void fetchData() async {
    emit(PotentiometerLoading());
    potentiometer = await fetchDataFromFirebase("potentiometer");
     emit(PotentiometerSuccess(potentiometer: potentiometer));
  }
}
