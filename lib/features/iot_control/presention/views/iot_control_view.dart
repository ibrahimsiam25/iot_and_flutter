import 'package:flutter/material.dart';
import 'widgets/iot_control_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manger/iot_control/iot_control_cubit.dart';

class IotControlView extends StatelessWidget {
  const IotControlView({super.key});
  static const String routeName = 'iot_control_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF201C32),
        body: BlocProvider(
          create: (context) => IotControlCubit(),
          child: BlocBuilder<IotControlCubit, IotControlState>(
            builder: (context, state) {
              return IotControlViewBody();
            },
          ),
        ));
  }
}
