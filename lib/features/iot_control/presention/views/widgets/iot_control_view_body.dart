import 'package:flutter/material.dart';
import '../../../../../core/functions/box_decoration.dart';
import '../../../../../core/widgets/custom_half_circle_progress.dart';
import 'package:iot_and_flutter/features/iot_control/presention/views/widgets/fan_bloc_builder.dart';
import 'package:iot_and_flutter/features/iot_control/presention/views/widgets/red_led_bloc_builder.dart';
import 'package:iot_and_flutter/features/iot_control/presention/views/widgets/green_led_bloc_builder.dart';
import 'package:iot_and_flutter/features/iot_control/presention/views/widgets/potentiometer_bloc_builder.dart';

class IotControlViewBody extends StatelessWidget {
  const IotControlViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: boxDecoration(),
      child:const SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Row(
              children: [
                RedLedBlocBuilder(),
                GreenLedBlocBuilder(),
              ],
            ),
           FanBlocBuilder(),
            PotentiometerBlocBuilder(),
          ],
        ),
      ),
    );
  }
}
