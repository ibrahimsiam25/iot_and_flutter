import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IotControlViewBody extends StatefulWidget {
  const IotControlViewBody({Key? key}) : super(key: key);

  @override
  State<IotControlViewBody> createState() => _IotControlViewBodyState();
}

class _IotControlViewBodyState extends State<IotControlViewBody> {
  final Stream<QuerySnapshot> _usersStream =FirebaseFirestore.instance.collection('iot_control').snapshots();
  bool _redLed = false;
 bool _greenLed = false;
  bool _fan = false;

  void _updateSwitchValue(bool value, String documentId,String field) async {
    try {
      await FirebaseFirestore.instance.collection('iot_control').doc(documentId).update({field: value,});
      setState(() {
switch (field) {
  case 'red':
    _redLed = value;
    break;
  case 'green':
    _greenLed = value;
    break;
  case 'fan':
    _fan = value;
    break;
}
      });
    } catch (e) {
      print('Failed to update data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final document =  snapshot.data ;

        _fan = document!.docs[0]['fan'];
         _redLed = document.docs[0]['red']; 
         _greenLed = document.docs[0]['green'];
          return SafeArea(
            child:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CustomCard(
                    iconOn: Icons.lightbulb,
                    iconOff: Icons.lightbulb,
                    color: Colors.red,
                    text: 'Red LED',
                    value: _redLed,
                    onToggle: () => _updateSwitchValue(!_redLed, document.docs[0].id,"red"), 
                  ),
                  CustomCard(
                    iconOn: Icons.lightbulb,
                    iconOff: Icons.lightbulb,
                    color: Colors.green,
                    text: 'green led',
                    value: _greenLed,
                    onToggle: () => _updateSwitchValue(!_greenLed, document.docs[0].id,"green"), 
                  ),
                ],
              ),
              CustomCard(
                  iconOn: Icons.flip_camera_android_rounded,
                  iconOff: Icons.mode_fan_off,
                  color: Colors.blue,
                  text: 'fan',
                  value: _fan,
                  onToggle: () => _updateSwitchValue(!_fan, document.docs[0].id,"fan"),),
                  SizedBox(height: 350),
            ],
          ),
         
          );
        

        return const Center(child: Text('No data available'));
      },
    );
  }
}





