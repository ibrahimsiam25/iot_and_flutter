import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_card.dart';
import 'package:iot_and_flutter/core/functions/firebase.dart';
import 'package:iot_and_flutter/features/iot_control/presention/manger/green_led/green_led_cubit.dart';


class GreenLedBlocBuilder extends StatelessWidget {
  const GreenLedBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GreenLedCubit, GreenLedState>(
      builder: (context, state) {
        if (state is GreenLedSuccess) {
          return CustomCard(
            iconOn: Icons.lightbulb,
            iconOff: Icons.lightbulb,
            color: Colors.green,
            text: 'Green LED',
            value: state.greenLed,
            onToggle: () => updateValue(!state.greenLed, "greenLed"),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
