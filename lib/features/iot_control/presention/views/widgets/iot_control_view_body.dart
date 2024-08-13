import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../../../core/widgets/custom_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iot_and_flutter/core/widgets/custom_half_circle_progress.dart';

class IotControlViewBody extends StatefulWidget {
  const IotControlViewBody({Key? key}) : super(key: key);

  @override
  State<IotControlViewBody> createState() => _IotControlViewBodyState();
}

class _IotControlViewBodyState extends State<IotControlViewBody> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('iot_control').snapshots();
  bool _redLed = false;
  bool _greenLed = false;
  bool _fan = false;
  double potentiometer = 0.0;
  late SpeechToText _speechToText;
  bool _hasSpeech = false;
  String _lastWords = '';
  @override
void initState() {
 super.initState();
  _initSpeechToText();
}
  Future<void> _initSpeechToText() async {
   _speechToText = SpeechToText();
  bool available = await _speechToText.initialize();
  if (available) {
    setState(() {
      _hasSpeech = false;
    });
  }
  }
  void _startListening() async {
    _speechToText.listen(onResult: (result) {
      setState(() {
        _lastWords = result.recognizedWords;
        _hasSpeech = true;
      });
    });
  }

  void _stopListening() async {
    print(_lastWords) ;
    _speechToText.stop();
    setState(() {   
      _hasSpeech = false;
    });
  }
    void _updateSwitchValue(bool value, String documentId, String field) async {
    try {
      await FirebaseFirestore.instance
          .collection('iot_control')
          .doc(documentId)
          .update({
        field: value,
      });
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

        final document = snapshot.data;

        _fan = document!.docs[0]['fan'];
        _redLed = document.docs[0]['red'];
        _greenLed = document.docs[0]['green'];
        potentiometer = document.docs[1]['potentiometer'] / 100;
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
                    value: _redLed,
                    onToggle: () => _updateSwitchValue(
                        !_redLed, document.docs[0].id, "red"),
                  ),
                  CustomCard(
                    iconOn: Icons.lightbulb,
                    iconOff: Icons.lightbulb,
                    color: Colors.green,
                    text: 'green led',
                    value: _greenLed,
                    onToggle: () => _updateSwitchValue(
                        !_greenLed, document.docs[0].id, "green"),
                  ),
                ],
              ),
              CustomCard(
                iconOn: Icons.flip_camera_android_rounded,
                iconOff: Icons.mode_fan_off,
                color: Colors.blue,
                text: 'fan',
                value: _fan,
                onToggle: () =>
                    _updateSwitchValue(!_fan, document.docs[0].id, "fan"),
              ),
              Container(
                  child: CustomHalfCircleProgress(percentage: potentiometer)),
              SizedBox(
                height: 50,
              ),
              Text(_lastWords,style: TextStyle(fontSize: 20,color: Colors.white),),
              IconButton(onPressed: _hasSpeech ? _stopListening : _startListening, icon: Icon(Icons.mic, size: 80)),
            ],
          ),
        );

        return const Center(child: Text('No data available'));
      },
    );
  }
}
