import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class IotControlViewBody extends StatefulWidget {
  const IotControlViewBody({Key? key}) : super(key: key);

  @override
  State<IotControlViewBody> createState() => _IotControlViewBodyState();
}

class _IotControlViewBodyState extends State<IotControlViewBody> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('leds').snapshots();
  bool _switchValue = false;

  void _updateSwitchValue(bool value, String documentId) async {
    try {
      await FirebaseFirestore.instance.collection('leds').doc(documentId).update({
        'red': value, // Send the updated value to Firestore
      });
      setState(() {
        _switchValue = value; // Update local state
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

        // Assume there's at least one document
        final document = snapshot.data!.docs.isNotEmpty ? snapshot.data!.docs[0] : null;

        if (document != null) {
          _switchValue = document['red']; // Set initial switch value

          return SafeArea(
            child: CustomCard(
              iconOn: Icons.lightbulb,
              iconOff: Icons.lightbulb,
              color: Colors.red,
              text: 'Red LED',
              value: _switchValue,
              onToggle: () => _updateSwitchValue(!_switchValue, document.id), // Toggle and update
            ),
          );
        }

        return const Center(child: Text('No data available'));
      },
    );
  }
}




//  Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Row(
//                 children: [
//                   CustomCard(
//                     iconOn: Icons.lightbulb,
//                     iconOff: Icons.lightbulb,
//                     color: Colors.red,
//                     text: 'Red LED',
//                     value: _switchValue,
//                     onToggle: () => _updateSwitchValue(snapshot.data!),
//                   ),
//                   CustomCard(
//                     iconOn: Icons.lightbulb,
//                     iconOff: Icons.lightbulb,
//                     color: Colors.green,
//                     text: 'green led',
//                     value: _switchValue,
//                     onToggle: () => _updateSwitchValue(snapshot.data!),
//                   ),
//                 ],
//               ),
//               CustomCard(
//                   iconOn: Icons.flip_camera_android_rounded,
//                   iconOff: Icons.mode_fan_off,
//                   color: Colors.blue,
//                   text: 'fan',
//                   value: _switchValue,
//                   onToggle: () => _updateSwitchValue(snapshot.data!)),
//                   SizedBox(height: 350),
//             ],
//           ),
         


  // FirebaseFirestore.instance
  //       .collection('leds')
  //       .doc("SQpudz4SuueHbzYlQgmq")
  //       .update({
  //     'red': !_switchValue, // Toggle the current value
  //   });