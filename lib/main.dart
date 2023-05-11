import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:landlord_tenent/firebase_options.dart';
import 'package:landlord_tenent/ui/page_splash.dart';

void main() async {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  if (kIsWeb == true) {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
          // name: 'create',
          options: DefaultFirebaseOptions.currentPlatform);
      runApp(const MyApp());
    } catch (e) {
      debugPrint(e.toString());
    }
  } else {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
          name: 'create', options: DefaultFirebaseOptions.currentPlatform);

      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    } on Exception catch (e) {
      debugPrint("something went wrong: $e");
    }
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    FlutterStatusbarcolor.setStatusBarColor(const Color(0xfff8f5f0));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Landlord- Tenant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
