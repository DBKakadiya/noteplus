import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:noteplus_demo/resources/resources.dart';
import '../presentation/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final colorizeColors = [
    colorPurple,
    colorBlue,
    colorYellow,
    colorRed,
  ];

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 6),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: deviceSize.height * 0.3),
          Center(
              child: Column(
            children: [
              Image.asset(
                'assets/images/splash_logo.png',
                height: deviceHeight(context) * 0.25,
                width: deviceWidth(context) * 0.3,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText('Note Plus Pro',
                      textStyle: textStyle40Bold()
                          .copyWith(fontFamily: 'BEARPAW_'),
                  colors: colorizeColors)
                ],
                isRepeatingAnimation: true,
              ),
            ],
          )),
        ],
      ),
    );
  }
}


// isListTextNote == null ? Text(textNotes![index].noteText!,
// style: textStyle16()) : isListTextNote ? SizedBox(
// height: deviceHeight(context) * 0.01,
// child: ListView.builder(
// itemCount: textNotes![index].noteText.length,
// itemBuilder: (context, i) => Row(
// children: [
// // Checkbox(value: textNotes![index].noteText[i].val, onChanged: (val){}),
// Text(textNotes![index].noteText[i].textFieldText.text),
// ],
// )),
// ) : Container(),