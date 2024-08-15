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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Rounded corners
        side: const BorderSide(
          color: Color.fromARGB(255, 134, 145, 207), // Border color
          width: 2.0, // Border width
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
            colors: [
              Color(0xff5ea0fe),
              Color(0xffa8e2ed),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
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
