import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import '../../../../../core/functions/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


part 'fan_state.dart';

class FanCubit extends Cubit<FanState> {
  FanCubit(this.usersStream) : super(FanInitial()) {
    usersStream.listen((snapshot) {
      emitStateBasedOnFirebaseChanges(snapshot);
    });
  }
  final Stream<QuerySnapshot> usersStream;
  late bool fan;
  void emitStateBasedOnFirebaseChanges(QuerySnapshot<Object?> snapshot) {
    for (var docChange in snapshot.docChanges) {
      if (docChange.type == DocumentChangeType.modified) {
        var data = docChange.doc.data() as Map<String, dynamic>?;
        switch (docChange.doc.id) {
          case "fan":
            fan = data!['value'];
            emit(FanSuccess(fan: fan));
            break;
        }
        print(
            "data--------------------------${docChange.doc.id}----- ${data!['value']}");
      }
    }
  }

  void fetchData() async {
    emit(FanLoading());
    fan = await fetchDataFromFirebase("fan");
     emit(FanSuccess(fan: fan));
  }
}
