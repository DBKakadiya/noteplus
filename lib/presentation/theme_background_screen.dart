import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noteplus_demo/model/drawer_data.dart';
import 'package:noteplus_demo/model/preference.dart';
import 'package:noteplus_demo/presentation/theme_apply%20_screen.dart';
import 'package:noteplus_demo/resources/resources.dart';

class ThemeBGScreen extends StatefulWidget {
  static const routeName = '/Theme-Background';
  final Color color;

  const ThemeBGScreen(this.color, {Key? key}) : super(key: key);

  @override
  _ThemeBGScreenState createState() => _ThemeBGScreenState();
}

class _ThemeBGScreenState extends State<ThemeBGScreen> {
  bool _isTheme = true;
  bool _isBackground = false;
  late FToast fToast;


  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 30.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: const Text("Success"),
    );

    fToast.showToast(
        child: toast,
        toastDuration: const Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.366),
                child: child,
              ),
              bottom: deviceHeight(context) * 0.08
          );
        });
  }

   void _backGroundImage(BuildContext context,int index) async {
      SharedPreference().storeValue('image', bgImageData[index].bgImage);
    }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          title: const Text('Theme & Background'),
        ),
        body: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.045),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isTheme = true;
                        _isBackground = false;
                      });
                    },
                    child: Container(
                      height: deviceHeight(context) * 0.068,
                      width: deviceWidth(context) * 0.33,
                      child: Center(
                        child: Text(
                          'Theme',
                          style: textStyle16(
                              _isTheme ? Colors.white : Colors.black87),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: _isTheme ? widget.color : Colors.grey.shade300,
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(30),
                              right: Radius.circular(30))),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isTheme = false;
                        _isBackground = true;
                      });
                    },
                    child: Container(
                      height: deviceHeight(context) * 0.068,
                      width: deviceWidth(context) * 0.33,
                      child: Center(
                        child: Text(
                          'Background',
                          style: textStyle16(
                              _isBackground ? Colors.white : Colors.black87),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: _isBackground
                              ? widget.color
                              : Colors.grey.shade300,
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(30),
                              right: Radius.circular(30))),
                    ),
                  ),
                ],
              ),
            ),
            if (_isTheme)
              Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 14,
                              crossAxisSpacing: 0,
                              childAspectRatio: 1.4),
                      itemCount: themeData.length,
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                themeData[index].isCheck = true;
                                for (int i = 0; i < themeData.length; i++) {
                                  if (i != index) {
                                    themeData[i].isCheck = false;
                                  }
                                }
                                Navigator.of(context).pushNamed(
                                    ApplyTheme.routeName,
                                    arguments: themeData[index].bgColor);
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: themeData[index].bgColor,
                              radius: 15,
                              child: themeData[index].isCheck
                                  ? Image.asset(
                                      icCheck,
                                      color: themeData[index].checkColor,
                                      height: deviceWidth(context) * 0.07,
                                    )
                                  : null,
                            ),
                          ))),
            if (_isBackground)
              Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                              childAspectRatio: 1.1),
                      itemCount: bgImageData.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                bgImageData[index].isCheck = true;
                                for (int i = 0; i < bgImageData.length; i++) {
                                  if (i != index) {
                                    bgImageData[i].isCheck = false;
                                  }
                                }
                              });
                              _showToast();
                              _backGroundImage(context,index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border:
                                      Border.all(color: Colors.black87, width: 1),
                                  image: DecorationImage(
                                    image: AssetImage(bgImageData[index].bgImage),
                                    fit: BoxFit.fill
                                  )),
                              child: bgImageData[index].isCheck
                                  ? const Icon(Icons.check,size: 28)
                                  : null,
                            )),
                      ))),
          ],
        ),
      ),
    );
  }
}
