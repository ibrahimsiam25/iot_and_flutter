import 'package:flutter/material.dart';
import 'package:iot_and_flutter/features/iot_control/presention/views/iot_control_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case IotControlView.routeName:
     return MaterialPageRoute(builder: (context) => const IotControlView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}