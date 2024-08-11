import 'package:flutter/material.dart';
import 'package:flutter/material.dart';


class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.iconOn,
    required this.iconOff,
    required this.text,
    required this.onToggle,
    required this.color,
    required this.value,
  }) : super(key: key);

  final IconData iconOn;
  final IconData iconOff;
  final String text;
  final VoidCallback onToggle;
  final bool value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Card(
          color: const Color(0xff363346),
          elevation: 50,
          shadowColor: const Color(0xFF373C59),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIcon(),
                const SizedBox(height: 20), // Spacer replacement
                _buildText(),
                const SizedBox(height: 20), // Spacer replacement
                _buildSwitch(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Icon _buildIcon() {
    return Icon(
      value ? iconOn : iconOff,
      color: value ? color : Colors.grey,
      size: 50,
    );
  }

  Text _buildText() {
    return Text(
      text,
      style: const TextStyle(fontSize: 20),
    );
  }

  Switch _buildSwitch() {
    return Switch(
      value: value,
      onChanged: (newValue) => onToggle(),
      activeColor: const Color(0xFF201C32),
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: Colors.grey.withOpacity(0.5),
    );
  }
}