import 'dart:async';
import 'package:flutter/material.dart';
import 'package:landlord_tenent/ui/first_screen.dart';
import 'package:landlord_tenent/utils/utils.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:responsive_container/responsive_container.dart';
import 'package:responsive_container_ns/responsive_container_ns.dart';
import '../LocalBindings.dart';
import 'page_home.dart';
import 'page_onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Screen? size;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      navigateFromSplash();
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    FlutterStatusbarcolor.setStatusBarColor(const Color(0xfff8f5f0));
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
      body: ResponsiveContainer(
        widthPercent: 100,
        heightPercent: 100,
        child: Container(
          color: const Color(0xfff8f5f0), // white color
          //color: Color(0xff1869d9),  // blue color
          child: Image.asset('assets/city.gif' // white gif
              //'assets/gif/city_blue.gif'  // blue gif
              ),
        ),
      ),
    );
  }

  Future navigateFromSplash() async {
    String? isOnBoard =
        await LocalStorage.sharedInstance.readValue(Constants.isOnBoard);
    print("onboard : $isOnBoard");
    String? isLoggedIn =
        await LocalStorage.sharedInstance.loadAuthStatus(Constants.isLoggedIn);
    print("isLoggedIn : $isLoggedIn");
    if (isOnBoard == null || isOnBoard == "0") {
      //Navigate to OnBoarding Screen.
      LocalStorage.sharedInstance
          .setAuthStatus(key: Constants.isLoggedIn, value: "false");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnBoardingPage()));
    } else {
      if (isLoggedIn == null || isLoggedIn == "false") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => FirstScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => SearchPage()));
      }
    }
  }
}
