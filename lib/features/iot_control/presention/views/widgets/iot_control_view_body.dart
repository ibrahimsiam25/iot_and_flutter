import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_and_flutter/core/widgets/shimmer_continar.dart';
import 'package:iot_and_flutter/features/iot_control/presention/manger/red_led/red_led_cubit.dart';
import 'package:iot_and_flutter/features/iot_control/presention/views/widgets/fan_bloc_builder.dart';
import 'package:iot_and_flutter/features/iot_control/presention/views/widgets/red_led_bloc_builder.dart';
import 'package:iot_and_flutter/features/iot_control/presention/views/widgets/green_led_bloc_builder.dart';
import 'package:iot_and_flutter/features/iot_control/presention/views/widgets/potentiometer_bloc_builder.dart';
import 'package:iot_and_flutter/features/iot_control/presention/views/widgets/speech_to_text_bloc_builder.dart';

class IotControlViewBody extends StatelessWidget {
  const IotControlViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RedLedCubit, RedLedState>(
      builder: (context, state) {
        if (state is RedLedLoading) {
          return ShimmerContinar();
        } else {
          return const SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(child: RedLedBlocBuilder()),
                        Expanded(child: GreenLedBlocBuilder()),
                      ],
                    ),
                    FanBlocBuilder(),
                    SizedBox(
                      height: 20,
                    ),
                    PotentiometerBlocBuilder(),
                    SpeechToTextBlocBuilder()
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
