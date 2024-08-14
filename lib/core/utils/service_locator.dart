import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('iot_control').snapshots();

  // Register the Stream with GetIt
  getIt.registerSingleton<Stream<QuerySnapshot>>(usersStream);
}
