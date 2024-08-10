import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({
    Key? key,
    required this.iconOn,
    required this.iconOff,
    required this.text,
    required this.onSwitchChanged, required this.color,
  }) : super(key: key);
  final IconData iconOn;
  final IconData iconOff;
  final String text;
  final Function onSwitchChanged;
  final Color color ;
  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool _isSwitchOn = false;

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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Icon( _isSwitchOn ? widget.iconOn : widget.iconOff,
              color: _isSwitchOn ? widget.color : Colors.grey,
              size: 50,),
                const Spacer(),
                Text(
                  widget.text,
                  style: const TextStyle(fontSize: 20),
                ),
                const Spacer(),
                Switch(
                  value: _isSwitchOn,
                  onChanged: (value) {
                    setState(() {
                      _isSwitchOn = value;
                      widget.onSwitchChanged(value);
                    });
                  },
                  activeColor: const Color(0xFF201C32),
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
