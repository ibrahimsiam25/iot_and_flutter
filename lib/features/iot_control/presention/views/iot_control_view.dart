import '../manger/fan/fan_cubit.dart';
import 'package:flutter/material.dart';
import 'widgets/iot_control_view_body.dart';
import '../manger/red_led/red_led_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manger/green_led/green_led_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iot_and_flutter/core/utils/service_locator.dart';

class IotControlView extends StatelessWidget {
  const IotControlView({super.key});
  static const String routeName = 'iot_control_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF201C32),
        body: MultiBlocProvider(
          providers:  [
            BlocProvider(
            create: (context) => RedLedCubit(getIt.get<Stream<QuerySnapshot>>())..fetchData(),
          ),
          BlocProvider(
            create: (context) => GreenLedCubit(getIt.get<Stream<QuerySnapshot>>())..fetchData(),
          ),
            BlocProvider(
            create: (context) => FanCubit(getIt.get<Stream<QuerySnapshot>>())..fetchData(),
          ),
          ],
          child:const IotControlViewBody(),
        ));
  }
}
