import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'iot_control_state.dart';

class IotControlCubit extends Cubit<IotControlState> {
  IotControlCubit() : super(IotControlInitial());
   final Stream<QuerySnapshot> usersStream =FirebaseFirestore.instance.collection('iot_control').snapshots();
    bool redLed = false;
  bool greenLed = false;
  bool fan = false;

  //   void updateSwitchValue(bool value, String field,AsyncSnapshot<QuerySnapshot<Object?>> snapshot) async {
  //     emit(IotControlLoading());
  //       final document0 = snapshot.data!.docs[0];
  //       final document1 = snapshot.data!.docs[1];
  //       fan = document0['fan'];
  //       redLed = document0['red'];z
  //       greenLed = document0['green'];
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('iot_control')
  //         .doc(documentId)
  //         .update({
  //       field: value,
  //     });
      
  //       switch (field) {
  //         case 'red':
  //           redLed = value;
  //           break;
  //         case 'green':
  //           greenLed = value;
  //           break;
  //         case 'fan':
  //           fan = value;
  //           break;
  //       }
  //        emit(IotControlSuccess());
     
  //   } catch (e) {
  //     emit(IotControlIFailure ());
  //     print('Failed to update data: $e');
  //   }
  // }
}
