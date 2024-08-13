import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'iot_control_state.dart';

class IotControlCubit extends Cubit<IotControlState> {
  IotControlCubit() : super(IotControlInitial());
 
}
