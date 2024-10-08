import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:iot_and_flutter/core/utils/service_locator.dart';
import 'package:iot_and_flutter/core/functions/on_generate_routes.dart';
import 'package:iot_and_flutter/features/iot_control/presention/views/iot_control_view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "iot-and-flutter",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
    );
     
    return const MaterialApp(
     onGenerateRoute: onGenerateRoute,
     initialRoute: IotControlView.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}

