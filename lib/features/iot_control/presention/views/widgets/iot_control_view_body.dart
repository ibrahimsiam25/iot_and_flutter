import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_and_flutter/features/iot_control/presention/manger/iot_control/iot_control_cubit.dart';
import '../../../../../core/widgets/custom_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IotControlViewBody extends StatefulWidget {
  const IotControlViewBody({super.key});

  @override
  State<IotControlViewBody> createState() => _IotControlViewBodyState();
}

class _IotControlViewBodyState extends State<IotControlViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IotControlCubit(),
      child: StreamBuilder<QuerySnapshot>(
        stream: context.read<IotControlCubit>().usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final document = snapshot.data;
          context.read<IotControlCubit>().fan = document!.docs[0]['fan'];
          context.read<IotControlCubit>().redLed = document.docs[0]['red'];
          context.read<IotControlCubit>().greenLed = document.docs[0]['green'];
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    CustomCard(
                      iconOn: Icons.lightbulb,
                      iconOff: Icons.lightbulb,
                      color: Colors.red,
                      text: 'Red LED',
                      value: context.read<IotControlCubit>().redLed,
                      onToggle: () => context
                          .read<IotControlCubit>()
                          .updateSwitchValue(
                              !context.read<IotControlCubit>().redLed,
                              document.docs[0].id,
                              "red"),
                    ),
                    CustomCard(
                      iconOn: Icons.lightbulb,
                      iconOff: Icons.lightbulb,
                      color: Colors.green,
                      text: 'green led',
                      value: context.read<IotControlCubit>().greenLed,
                      onToggle: () => context
                          .read<IotControlCubit>()
                          .updateSwitchValue(
                              !context.read<IotControlCubit>().greenLed,
                              document.docs[0].id,
                              "green"),
                    ),
                  ],
                ),
                CustomCard(
                  iconOn: Icons.flip_camera_android_rounded,
                  iconOff: Icons.mode_fan_off,
                  color: Colors.blue,
                  text: 'fan',
                  value: context.read<IotControlCubit>().fan,
                  onToggle: () => context
                      .read<IotControlCubit>()
                      .updateSwitchValue(!context.read<IotControlCubit>().fan,
                          document.docs[0].id, "fan"),
                ),
                const SizedBox(height: 350),
              ],
            ),
          );

          // return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}
