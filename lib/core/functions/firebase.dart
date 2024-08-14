import 'package:cloud_firestore/cloud_firestore.dart';

Map<String, dynamic> values = {};
void updateValue(bool val, String doc) async {
  print("updating value $val + $doc");
  await FirebaseFirestore.instance.collection('iot_control').doc(doc).update({
    "value": val,
  });
}

Future<dynamic> fetchDataFromFirebase(String doc) async {
  var valueOfDoc;
  await FirebaseFirestore.instance
      .collection('iot_control')
      .get()
      .then((value) {
    value.docs.forEach((element) {
      String key = element.id;
      Map<String, dynamic> data = element.data();
      values[key] = data;
    });

    switch (doc) {
      case "redLed":
        valueOfDoc = values['redLed']['value'];
        break;
      case "greenLed":
        valueOfDoc = values['greenLed']['value'];
        break;
      case "fan":
        valueOfDoc = values['fan']['value'];
        break;
    }

    print("emit initial state");
  });
  return valueOfDoc;
}



