import 'package:final_year_project/app.dart';
import 'package:final_year_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'data/repo/auth/auth_repository.dart';

void main() async {
  // widgets bindings
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // local storage
  await GetStorage.init();

  // native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const App());
}
