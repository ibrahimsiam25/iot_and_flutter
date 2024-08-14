import 'package:flutter/material.dart';
import 'package:iot_and_flutter/features/iot_control/presention/views/widgets/fan_bloc_builder.dart';
import 'package:iot_and_flutter/features/iot_control/presention/views/widgets/red_led_bloc_builder.dart';
import 'package:iot_and_flutter/features/iot_control/presention/views/widgets/green_led_bloc_builder.dart';

class IotControlViewBody extends StatelessWidget {
  const IotControlViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            RedLedBlocBuilder(),
           GreenLedBlocBuilder(),
          ],
        ),
        FanBlocBuilder()
      ],
    );
  }
}
