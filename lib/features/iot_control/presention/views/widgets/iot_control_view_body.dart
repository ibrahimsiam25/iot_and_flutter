import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../../../core/widgets/custom_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iot_and_flutter/core/widgets/custom_half_circle_progress.dart';
import 'package:iot_and_flutter/features/iot_control/presention/views/widgets/custom_icon_mic.dart';

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
  double potentiometer = 0;
  late SpeechToText _speechToText;
  bool _hasSpeech = false;
  String _lastWords = '';
  @override
  void initState() {
    super.initState();
    _initSpeechToText();
  }
  void controlByVoice(){
 if(_lastWords=='turn off the red light'){
   _updateSwitchValue(!_redLed, "red");                  
 }   else if(_lastWords=='turn on the red light'){
   _updateSwitchValue(!_redLed, "red");
 } else if(_lastWords=='turn off the green light'){   
   _updateSwitchValue(!_greenLed, "green");
 } else if(_lastWords=='turn on the green light'){  
   _updateSwitchValue(!_greenLed, "green");
 } else if(_lastWords=='turn off the fan'){ 
   _updateSwitchValue(!_fan, "fan");
 } else if(_lastWords=='turn on the fan'){    
   _updateSwitchValue(!_fan, "fan");
 } else if(_lastWords=='turn off the light '){
   _updateSwitchValue(!_redLed, "red");
   _updateSwitchValue(!_greenLed, "green");
  }
  else if(_lastWords=='turn on the light '){
   _updateSwitchValue(!_redLed, "red");
   _updateSwitchValue(!_greenLed, "green");
  }
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
        if (result.finalResult) {
      // Print the recognized words when speech ends

      controlByVoice();
      _stopListening();
    }
    });
  }

  void _stopListening() async {

    _speechToText.stop();
    await Future.delayed(Duration(seconds: 1));
     _lastWords = '';
      
    setState(() {
      _hasSpeech = false;
    });
  }

  void _updateSwitchValue(bool value,  String field) async {
    try {
      
      await FirebaseFirestore.instance
          .collection('iot_control')
          .doc("leds")
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
        potentiometer = (document.docs[1]['potentiometer'] as int).toDouble();
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff4d6c92),
                Color(0xff1d1a30),
                Color(0xff1d1a30),
                Color(0xff1d1a30),
                Color(0xff4d6c92),
              ],
              tileMode: TileMode.clamp,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: SafeArea(
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
                            !_redLed, "red"),
                      ),
                      CustomCard(
                        iconOn: Icons.lightbulb,
                        iconOff: Icons.lightbulb,
                        color: Colors.green,
                        text: 'Green LED',
                        value: _greenLed,
                        onToggle: () => _updateSwitchValue(
                            !_greenLed,  "green"),
                      ),
                    ],
                  ),
                  CustomCard(
                    iconOn: Icons.flip_camera_android_rounded,
                    iconOff: Icons.mode_fan_off,
                    color: Colors.blue,
                    text: 'Fan',
                    value: _fan,
                    onToggle: () =>
                        _updateSwitchValue(!_fan, "fan"),
                  ),
                
                  Container(
                      child:
                          CustomHalfCircleProgress(percentage: potentiometer)),
                  
                  Text(
                    _lastWords,
                    style: TextStyle(fontSize: 20, color: Colors.white,),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
             IconButton(
                      onPressed: _hasSpeech ? _stopListening : _startListening,
                      icon: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              Color(0xff5ea0fe),
                              Color(0xffa8e2ed),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ).createShader(bounds);
                        },
                        child: Icon(
                          Icons.mic,
                          size: 80,
                          color: Colors
                              .white, // The color here is a base color that will be masked by the gradient
                        ),
                      ))
                ],
              ),
            ),
          ),
        );

        return const Center(child: Text('No data available'));
      },
    );
  }
}



