import 'dart:async';

import 'package:covid_19_tracker_app/View/world_state_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this
  )..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context,
      MaterialPageRoute(builder: (context){
        return WorldStateScreen();
      }),
      );
    });
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(
                animation: controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: Center(
                    child: Image(image: AssetImage("assets/images/virus.png"),),
                  ),
                ),
                builder: (BuildContext context , Widget? child){
                  return Transform.rotate(
                    angle: controller.value * 2.0 * math.pi,
                    child: child,
                  );
                }
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .08,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text("Covid-19\nTracker App" ,  textAlign: TextAlign.center ,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),),
            )
          ],
        ),
      ),
    );
  }
}
