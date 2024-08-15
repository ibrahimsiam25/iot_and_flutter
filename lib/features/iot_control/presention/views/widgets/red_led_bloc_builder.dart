import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manger/red_led/red_led_cubit.dart';
import '../../../../../core/functions/firebase.dart';
import '../../../../../core/widgets/custom_card.dart';
import 'package:iot_and_flutter/core/widgets/shimmer_continar.dart';




class RedLedBlocBuilder extends StatelessWidget {
  const RedLedBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   
    return BlocBuilder<RedLedCubit, RedLedState>(
      builder: (context, state) {
        if (state is RedLedSuccess) {
      return CustomCard(
        iconOn: Icons.lightbulb,
        iconOff: Icons.lightbulb,
        color: Colors.red,
        text: 'Red LED',
        value:state.redLed, 
        onToggle: () => updateValue(
     !state.redLed, "redLed"),
      );
    } 
     else{
      return Container();
    }
      },
    );
  }
}