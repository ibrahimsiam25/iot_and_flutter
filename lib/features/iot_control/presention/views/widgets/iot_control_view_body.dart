import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_card.dart';

bool _isSwitchOn = false;

class IotControlViewBody extends StatefulWidget {
  const IotControlViewBody({super.key});

  @override
  State<IotControlViewBody> createState() => _IotControlViewBodyState();
}

class _IotControlViewBodyState extends State<IotControlViewBody> {
  @override
  Widget build(BuildContext context) {
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
              text: 'Work',
              onSwitchChanged: (bool value) {
                // Do something based on the switch value
                print('Switch value changed: $value');
              },
            ),
            CustomCard(
              iconOn: Icons.lightbulb,
              iconOff: Icons.lightbulb,
              color: Colors.green,
              text: 'Work',
              onSwitchChanged: (bool value) {
                // Do something based on the switch value
                print('Switch value changed: $value');
              },
            ),
        
          ],
        ),    CustomCard(
              iconOn: Icons.lightbulb,
              iconOff: Icons.lightbulb,
              color: Colors.green,
              text: 'Work',
              onSwitchChanged: (bool value) {
                // Do something based on the switch value
                print('Switch value changed: $value');
              },
            ),
         
      ],
    ));
  }
}
