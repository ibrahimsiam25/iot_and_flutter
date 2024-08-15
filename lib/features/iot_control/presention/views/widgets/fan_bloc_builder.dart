import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/functions/firebase.dart';
import '../../../../../core/widgets/custom_card.dart';
import '../../../../../core/widgets/shimmer_continar.dart';
import 'package:iot_and_flutter/features/iot_control/presention/manger/fan/fan_cubit.dart';



class FanBlocBuilder extends StatelessWidget {
  const FanBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FanCubit,FanState>(
      builder: (context, state) {
        if (state is FanSuccess) {
          return CustomCard(
            iconOn: Icons.flip_camera_android_rounded,
            iconOff: Icons.mode_fan_off,
            color: Colors.blue,
            text: 'Fan',
            value: state.fan,
            onToggle: () => updateValue(!state.fan, "fan"),
          );
        } 
         else {
          return Container();
        }
      },
    );
  }
}
