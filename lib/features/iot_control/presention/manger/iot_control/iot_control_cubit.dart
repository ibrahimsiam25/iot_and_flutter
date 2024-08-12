import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'iot_control_state.dart';

class IotControlCubit extends Cubit<IotControlState> {
  IotControlCubit() : super(IotControlInitial());
  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('iot_control').snapshots();
  bool redLed = false;
  bool greenLed = false;
  bool fan = false;

  //Update Value
  void updateSwitchValue(bool value, String documentId, String field) async {
    try {
      await FirebaseFirestore.instance
          .collection('iot_control')
          .doc(documentId)
          .update({
        field: value,
      });
      switch (field) {
        case 'red':
          redLed = value;
          break;
        case 'green':
          greenLed = value;
          break;
        case 'fan':
          fan = value;
          break;
      }
    } catch (e) {
      debugPrint('Failed to update data: $e');
    }
  }

  //Stream Builder
  streamBuilder(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot,
      Widget widget) {
    if (snapshot.hasError) {
      return const Center(child: Text('Something went wrong'));
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    final document = snapshot.data;

    fan = document!.docs[0]['fan'];
    redLed = document.docs[0]['red'];
    greenLed = document.docs[0]['green'];
    return widget;
  }
}
